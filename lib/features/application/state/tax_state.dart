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
  TaxProviderState _state = TaxProviderState.init;
  bool _isSubmitButtonEnabled = false;

  TextEditingController get countryTextController => _countryTextController;
  TextEditingController get taxIDTextController => _taxIDTextController;

  TaxResidence? get primaryTaxResidence => _primaryTaxResidence;
  List<TaxResidence> get secondryTaxResidences => _secondryTaxResidences;
  TaxProviderState get state => _state;
  bool get isSubmitButtonEnabled => _isSubmitButtonEnabled;

  TaxState({required this.taxUseCases}) {
    _countryTextController = TextEditingController();
    _taxIDTextController = TextEditingController();
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
  }
}
