import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTaxRepository extends Mock implements TaxRepository {}

// flutter test test/features/domain/usecases/tax_use_cases_test.dart
void main() {
  late TaxUseCases taxUseCases;
  late MockTaxRepository mockTaxRepository;
  // this function it will be start before test functions work
  setUpAll(() {
    // define instances
    mockTaxRepository = MockTaxRepository();
    // set mock mockTaxRepository value to the taxUseCases instance of taxUseCases
    taxUseCases = TaxUseCases(taxRepository: mockTaxRepository);
  });

  Tax tax = Tax(
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

  test('should the check of the getTaxData function passed with right return',
      () async {
    when(mockTaxRepository.getTaxData()).thenAnswer((_) async => Right(tax));

    final result = await taxUseCases.getTaxData();
    expect(result, Right(tax));

    verify(mockTaxRepository.getTaxData());
    verifyNoMoreInteractions(mockTaxRepository);
  });

  test('should the check of the login getTaxData fail with left return',
      () async {
    when(mockTaxRepository.getTaxData())
        .thenAnswer((_) async => const Left(Failure(message: 'fails')));

    final result = await taxUseCases.getTaxData();
    expect(result, const Left(Failure(message: 'fails')));

    verify(mockTaxRepository.getTaxData());
    verifyNoMoreInteractions(mockTaxRepository);
  }); //end of taxUseCases test
}
