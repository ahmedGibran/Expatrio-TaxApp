import 'dart:convert';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixture/fixture_reader.dart';

//flutter test test/features/infrastructure/model/tax_models/tax_model_test.dart
void main() {
  // make instance from tax model and set the default params.
  TaxModel tax = TaxModel(
      usPerson: false,
      usTaxId: null,
      primaryTaxResidence:
          const TaxResidenceModel(country: "AF", id: "1234567"),
      secondaryTaxResidence: const [
        TaxResidenceModel(country: "FR", id: "15236")
      ],
      w9FileId: 320459,
      w9File: W9FileModel(
          id: 320459,
          createdAt: DateTime.tryParse("2023-12-14T13:12:24.371608"),
          modifiedAt: DateTime.tryParse("2023-12-14T13:12:24.435052"),
          fileName: "FORM_W9_03c91726-b202-4ff7-bead-ea6fc0687b56.pdf",
          dataType: "FORM_W9",
          author: null,
          state: null,
          field: null,
          label: null,
          description: null,
          fileUrl:
              "https://dev-files.expatrio.com/FORM_W9_03c91726-b202-4ff7-bead-ea6fc0687b56.pdf?response-content-type=application/pdf&response-content-disposition=inline%3B+filename%3DFORM_W9_03c91726-b202-4ff7-bead-ea6fc0687b56.pdf&Expires=1704586427&Signature=HYp2XD1dIC-BAgD9HcwrHoZ3gFkdc0bsllFb2VrC6Kms-XbJaaa~vc2r8Dj0V~nf2SB7K1WHGCGrhL~AF4iubHco1iNYjnL-c1BmE7imZvowM4v~S4HFfiPu5v09RnmpA26VnpezHjp2w2JMeIdYGzhJFBcJgeJbWaSa6ekMIBKUlypu8DCZM4YeuUQWv8hzke0iyQQkhmiWdkqs~Bsw8F1KPihwmumH~R625RsUKyX7JTqDRNP3UGXd6G-f6XlTu7a6fhhSdY0pcPMFvYlEuFEixGfnClllTUHgBjYPpkeP9wehn4MwHdlQc92YlnbrU6IPfQ3QeX61FSknzaG3Jg__&Key-Pair-Id=APKAJU3M3ZIAQ775OZBQ",
          invalid: false));

  test("fromJson", () async {
    // get data from local json file
    final Map<String, dynamic> mapData =
        json.decode(fixture("cached_tax_data.json"));
    TaxModel result;
    // result will take the mappedData from the tax json file
    result = TaxModel.fromJson(mapData);
    // here we can check so if it is confirmed or not
    expect(result, tax);
  });

  test("toJson", () async {
    final result = tax.toJson();

    // mapping data
    Map<String, dynamic> mapOfData = {
      "usPerson": false,
      "usTaxId": null,
      "primaryTaxResidence": {"country": "AF", "id": "1234567"},
      "secondaryTaxResidence": [
        {"country": "FR", "id": "15236"}
      ],
      "w9FileId": 320459,
      "w9File": {
        "id": 320459,
        "createdAt": "2023-12-14T13:12:24.371608",
        "modifiedAt": "2023-12-14T13:12:24.435052",
        "fileName": "FORM_W9_03c91726-b202-4ff7-bead-ea6fc0687b56.pdf",
        "dataType": "FORM_W9",
        "author": null,
        "state": null,
        "field": null,
        "label": null,
        "description": null,
        "fileUrl":
            "https://dev-files.expatrio.com/FORM_W9_03c91726-b202-4ff7-bead-ea6fc0687b56.pdf?response-content-type=application/pdf&response-content-disposition=inline%3B+filename%3DFORM_W9_03c91726-b202-4ff7-bead-ea6fc0687b56.pdf&Expires=1704586427&Signature=HYp2XD1dIC-BAgD9HcwrHoZ3gFkdc0bsllFb2VrC6Kms-XbJaaa~vc2r8Dj0V~nf2SB7K1WHGCGrhL~AF4iubHco1iNYjnL-c1BmE7imZvowM4v~S4HFfiPu5v09RnmpA26VnpezHjp2w2JMeIdYGzhJFBcJgeJbWaSa6ekMIBKUlypu8DCZM4YeuUQWv8hzke0iyQQkhmiWdkqs~Bsw8F1KPihwmumH~R625RsUKyX7JTqDRNP3UGXd6G-f6XlTu7a6fhhSdY0pcPMFvYlEuFEixGfnClllTUHgBjYPpkeP9wehn4MwHdlQc92YlnbrU6IPfQ3QeX61FSknzaG3Jg__&Key-Pair-Id=APKAJU3M3ZIAQ775OZBQ",
        "invalid": false
      }
    };
    // here we can check so if it is confirmed or not
    expect(result, mapOfData);
  });
}
