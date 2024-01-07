import 'dart:convert';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixture/fixture_reader.dart';

//flutter test test/features/infrastructure/model/tax_models/tax_residence_model_test.dart
void main() {
  // make instance from tax residence model and set the default params.
  const TaxResidenceModel taxResidence =
      TaxResidenceModel(country: "AF", id: "1234567");

  test("fromJson", () async {
    // get data from local json file
    final Map<String, dynamic> mapData =
        json.decode(fixture("cached_tax_residence_data.json"));
    TaxResidenceModel result;
    // result will take the mappedData from the tax residence json file
    result = TaxResidenceModel.fromJson(mapData);
    // here we can check so if it is confirmed or not
    expect(result, taxResidence);
  });

  test("toJson", () async {
    final result = taxResidence.toJson();

    // mapping data
    Map<String, dynamic> mapOfData = {"country": "AF", "id": "1234567"};
    // here we can check so if it is confirmed or not
    expect(result, mapOfData);
  });
}
