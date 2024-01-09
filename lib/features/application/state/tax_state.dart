import 'dart:ffi';

import 'package:expatrio_tax_task/core/utils/constants/countries_constants.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';

enum TaxProviderState { init, loading, error, success }

class TaxState extends ChangeNotifier {
  late final TextEditingController _countryTextController;
  late final TextEditingController _taxIDTextController;

  late final TaxUseCases taxUseCases;
  TaxResidence? _primaryTaxResidence;
  List<TaxResidence> _secondryTaxResidences = [];
  Map<int, TaxResidence> _taxResidencesMap = {};
  List<int> _taxForms = [];
  TaxProviderState _state = TaxProviderState.init;
  bool _isSubmitButtonEnabled = false;

  String _selectedTaxCountry = '';
  String _taxId = '';

  List<CountryInfo> _countryInfos = [];

  TextEditingController get countryTextController => _countryTextController;
  TextEditingController get taxIDTextController => _taxIDTextController;

  TaxResidence? get primaryTaxResidence => _primaryTaxResidence;
  List<TaxResidence> get secondryTaxResidences => _secondryTaxResidences;
  Map<int, TaxResidence> get taxResidencesMap => _taxResidencesMap;
  TaxProviderState get state => _state;
  bool get isSubmitButtonEnabled => _isSubmitButtonEnabled;
  List<CountryInfo> get countryInfos => _countryInfos;
  List<int> get taxForms => _taxForms;

  TaxState({required this.taxUseCases}) {
    _countryTextController = TextEditingController();
    _taxIDTextController = TextEditingController();
    _countryInfos = [...CountriesConstants.countryInfos];
    _taxForms.add(1);
    _getTaxData();
  }

  Future<void> _getTaxData() async {
    _state = TaxProviderState.loading;
    notifyListeners();
    final result = await taxUseCases.getTaxData();

    result?.fold((l) {
      _state = TaxProviderState.error;
    }, (r) {
      _state = TaxProviderState.success;
      _primaryTaxResidence = r.primaryTaxResidence;
      _secondryTaxResidences = r.secondaryTaxResidence;
    });
    notifyListeners();
  }

  Future<void> updateTaxData(Tax tax) async {
    _state = TaxProviderState.loading;
    notifyListeners();
    final result = await taxUseCases.updateTaxData(tax);

    result?.fold((l) {
      _state = TaxProviderState.error;
    }, (r) async {
      _state = TaxProviderState.success;
    });
    notifyListeners();
  }

  void selectTaxCountry(CountryInfo countryInfo, int formIndex) {
    print("CountryInfo $countryInfo, formIndex: $formIndex");
    final taxResidences = TaxResidence(id: '', country: countryInfo.code);
    _taxResidencesMap.update(formIndex, (currentTaxResidence) {
      return TaxResidence(id: currentTaxResidence.id, country: countryInfo.code);
    }, ifAbsent: () => taxResidences);
    _removeSelectedCountriesFromTheList();
    notifyListeners();
  }

  _removeSelectedCountriesFromTheList() {
    _countryInfos = [...CountriesConstants.countryInfos];
    _taxResidencesMap.forEach((key, value) {
      _countryInfos.removeWhere((element) => element.code == value.country);
    });
  }

  void addTaxForm() {
    //Todo add a new tax form
    print("addTaxForm");
    _taxForms.add(1);
    notifyListeners();
  }

  void removeTaxForm(int formIndex) {
    _taxForms.removeAt(formIndex);
    print("removeTaxForm");
    notifyListeners();
  }

  void addTaxId(String taxId, int formIndex) {
    //Todo addTaxId
    print("addTaxId :  $taxId, formIndex: $formIndex");
    final taxResidences = TaxResidence(id: taxId, country: '');
    _taxResidencesMap.update(formIndex, (currentTaxResidence) {
      return TaxResidence(id: taxId, country: currentTaxResidence.country);
    }, ifAbsent: () => taxResidences);
    notifyListeners();
  }
}
