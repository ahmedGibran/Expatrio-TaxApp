import 'dart:convert';
import 'dart:io';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixture/fixture_reader.dart';
import 'auth_remote_data_test.mocks.dart';

//flutter test test/features/infrastructure/dataresource/remote/tax_remote_data_test.dart
void main() {
  late TaxRemoteDataImpl taxRemoteDataImpl;
  late MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    taxRemoteDataImpl = TaxRemoteDataImpl(httpClient: mockClient);
  });

  group('taxRemoteDataImpl test group of getTaxData', () {
    void callSuccess200() {
      when(mockClient.get(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      )).thenAnswer((_) async => http.Response(fixture('cached_tax_data.json'), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
    }

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

    test("should call getTaxData Method and statues code should be 200 (success)", () async {
      callSuccess200();
      await taxRemoteDataImpl.getTaxData();
      verify(mockClient.get(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      ));
    });

    test("should call getTaxData Method with tax obj as a response", () async {
      callSuccess200();
      final result = await taxRemoteDataImpl.getTaxData();
      expect(result, tax);
    });

    test("should throw exception when the statues code of http.get does not equal 200 (success)", () async {
      when(mockClient.get(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      )).thenAnswer((_) async => http.Response(fixture('cached_tax_data.json'), 500,
          headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));

      final result = taxRemoteDataImpl.getTaxData;
      expect(() => result(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('taxRemoteDataImpl test group of updateTaxData', () {
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

    void callSuccess200() {
      when(mockClient.put(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
        body: json.encode(tax.toJson()),
      )).thenAnswer((_) async =>
          http.Response('', 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
    }

    test("should call updateTaxData Method and statues code should be 200 (success)", () async {
      callSuccess200();
      await taxRemoteDataImpl.updateTaxData(tax);
      verify(mockClient.put(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
        body: json.encode(tax.toJson()),
      ));
    });

    test("should call updateTaxData Method without any issues in the response", () async {
      callSuccess200();
      final result = await taxRemoteDataImpl.updateTaxData(tax);
      expect(() => result, returnsNormally);
    });

    test("should throw exception when the statues code of http.get does not equal 200 (success)", () async {
      when(mockClient.put(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
        body: json.encode(tax.toJson()),
      )).thenAnswer((_) async =>
          http.Response('', 500, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));

      final result = taxRemoteDataImpl.updateTaxData;
      expect(() => result(tax), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
