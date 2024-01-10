import 'dart:convert';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'auth_local_data_test.mocks.dart';

//flutter test test/features/infrastructure/dataresource/local/tax_local_data_test.dart
void main() {
  late TaxLocalDataImpl taxLocalDataImpl;
  late MockFlutterSecureStorage mockStorage;

  setUpAll(() {
    mockStorage = MockFlutterSecureStorage();
    taxLocalDataImpl = TaxLocalDataImpl(storage: mockStorage);
  });

  group('taxLocalDataImpl test group', () {
    TaxModel tax = TaxModel(
        usPerson: false,
        usTaxId: null,
        primaryTaxResidence: const TaxResidenceModel(country: "AF", id: "1234567"),
        secondaryTaxResidence: const [TaxResidenceModel(country: "FR", id: "15236")],
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

    test("should call cacheTaxData Method and store the tax obj as string", () async {
      await taxLocalDataImpl.cacheTaxData(tax);
      verify(mockStorage.write(key: CACHED_TAX_DATA, value: jsonEncode(tax.toJson())));
    });

    test("should call getTaxData Method and return the stored tax obj", () async {
      when(mockStorage.read(key: CACHED_TAX_DATA)).thenAnswer((_) async => jsonEncode(tax.toJson()));
      final result = await taxLocalDataImpl.getTaxData();
      verify(mockStorage.read(key: CACHED_TAX_DATA));
      expect(result, tax);
    });
  });
}
