import 'package:expatrio_tax_task/core/utils/constants/countries_constants.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter/material.dart';

enum TaxProviderState { init, loading, error, success }

class TaxState extends ChangeNotifier {
  late final TaxUseCases taxUseCases;
  late final TextEditingController _searchTextEditingController;
  Map<int, TaxResidence> _taxResidencesMap = {};
  final List<int> _taxForms = [];
  TaxProviderState _state = TaxProviderState.init;
  bool _isSubmitButtonEnabled = false;
  bool? _isInformationAccuracyVerified;

  List<CountryInfo> _countryInfos = [];

  Map<int, TaxResidence> get taxResidencesMap => _taxResidencesMap;
  TaxProviderState get state => _state;
  bool get isSubmitButtonEnabled => _isSubmitButtonEnabled;
  bool? get isInformationAccuracyVerified => _isInformationAccuracyVerified;
  List<CountryInfo> get countryInfos => _countryInfos;
  List<int> get taxForms => _taxForms;
  TextEditingController get searchTextEditingController => _searchTextEditingController;

  TaxState({required this.taxUseCases}) {
    _searchTextEditingController = TextEditingController();
    _searchTextEditingController.addListener(_listenToSearchTextChange);
    _countryInfos = [...CountriesConstants.countryInfos];
    _taxForms.add(0);
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
      _taxResidencesMap[0] = r.primaryTaxResidence;
      for (int i = 0; i < r.secondaryTaxResidence.length; i++) {
        _taxForms.add(i + 1);
        _taxResidencesMap[i + 1] = r.secondaryTaxResidence[i];
      }
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
    _taxForms.add(_taxForms.length);
    notifyListeners();
  }

  void removeTaxForm(int formIndex) {
    _taxForms.remove(formIndex);
    _taxResidencesMap.remove(formIndex);
    _reOrderTaxFormsData();
    _removeSelectedCountriesFromTheList();
    notifyListeners();
  }

  void addTaxId(String taxId, int formIndex) {
    final taxResidences = TaxResidence(id: taxId, country: '');
    _taxResidencesMap.update(formIndex, (currentTaxResidence) {
      return TaxResidence(id: taxId, country: currentTaxResidence.country);
    }, ifAbsent: () => taxResidences);
    notifyListeners();
  }

  setInformationAccuracyState(bool? isChecked) {
    _isInformationAccuracyVerified = isChecked;
    notifyListeners();
  }

  _reOrderTaxFormsData() {
    Map<int, TaxResidence> newTaxResidencesMap = {};
    List<TaxResidence> newTaxResidences = [];
    _taxResidencesMap.forEach((key, value) {
      newTaxResidences.add(value);
    });
    for (var x = 0; x < _taxForms.length; x++) {
      _taxForms[x] = x;
      newTaxResidencesMap[x] = newTaxResidences[x];
    }
    _taxResidencesMap = newTaxResidencesMap;
  }

  Future<void> submitTaxDataUpdates() async {
    _isInformationAccuracyVerified ??= false;
    _isSubmitButtonEnabled = _isInformationAccuracyVerified == true && _taxResidencesMap.isNotEmpty;
    _taxResidencesMap.forEach((key, value) {
      if (value.country.isEmpty || value.country.isEmpty) {
        _isSubmitButtonEnabled = false;
      }
    });
    notifyListeners();
    if (_isSubmitButtonEnabled) {
      updateTaxData(generateTaxModel());
    }
  }

  TaxModel generateTaxModel() {
    TaxModel tax;
    List<TaxResidenceModel> secondaryTaxResidences = [];
    _taxResidencesMap.forEach((key, value) {
      if (key != 0) {
        secondaryTaxResidences.add(TaxResidenceModel(id: value.id, country: value.country));
      }
    });
    tax = TaxModel(
      usTaxId: null,
      usPerson: null,
      primaryTaxResidence: TaxResidenceModel(id: _taxResidencesMap[0]!.id, country: _taxResidencesMap[0]!.country),
      secondaryTaxResidence: secondaryTaxResidences,
      w9FileId: null,
      w9File: null,
    );
    return tax;
  }

  void _listenToSearchTextChange() {
    final search = _searchTextEditingController.text;
    _removeSelectedCountriesFromTheList();
    if (search.isEmpty) {
    } else {
      _countryInfos = [..._countryInfos.where((element) => element.label.toLowerCase().contains(search)).toList()];
    }
    notifyListeners();
  }
}
