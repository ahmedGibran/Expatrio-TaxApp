import 'dart:convert';
import 'dart:io';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixture/fixture_reader.dart';
import 'auth_remote_data_test.mocks.dart';

@GenerateMocks([http.Client])
//flutter test test/features/infrastructure/dataresource/remote/auth_remote_data_test.dart
void main() {
  late AuthRemoteDataImpl authRemoteDataImpl;
  late MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    authRemoteDataImpl = AuthRemoteDataImpl(httpClient: mockClient);
  });

  group('authRemoteDataImpl test group', () {
    void callSuccess200() {
      when(mockClient.post(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
        body: json.encode(<String, String>{'email': 'email', 'password': 'password'}),
      )).thenAnswer((_) async => http.Response(fixture('cached_user_data.json'), 200,
          headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));
    }

    UserModel user = UserModel(
        accessToken:
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ4cDppZCI6IjExMzg3NSIsInhwOmxhc3ROYW1lIjoiQmEgQ2JhIEFpb24iLCJ4cDpzdWJqZWN0IjoiQm9ib24gQmEgQ2JhIEFpb24iLCJ4cDpwdiI6MiwiaXNzIjoieC1wYXRyaW8iLCJ4cDplbWFpbCI6InRpdG8rYnM3OTJAZXhwYXRyaW8uY29tIiwieHA6cm9sZSI6IkNVU1RPTUVSIiwieHA6Zmlyc3ROYW1lIjoiQm9ib24iLCJleHAiOjE3MDQ1ODYyMzcsImlhdCI6MTcwNDU4MjYzNywianRpIjoiMTIzIn0.5mXCBtiP6O-mfYhhQQUIwVdH9n_olZR9ieoWrABx-htwN07HLcVKUXYZVssIsNl1W2aJ_N0VlyOzxSId3xMc6Q",
        accessTokenExpiresAt: DateTime.tryParse("2024-01-07T00:10:37.183369Z"),
        userRole: "CUSTOMER",
        xpm: false,
        userId: 113875,
        subject: const UserSubjectModel(
          userId: 113875,
          userUuid: "7fe524e1-9575-4050-b209-8ebaf7094347",
          lastName: "Ba Cba Aion",
          firstName: "Bobon",
          fullName: "Bobon Ba Cba Aion",
          email: "tito+bs792@expatrio.com",
          role: "CUSTOMER",
          isAdmin: false,
        ),
        maxAgeSeconds: 3600);

    test("should call login Method and statues code should be 200 (success)", () async {
      callSuccess200();
      await authRemoteDataImpl.login('email', 'password');
      verify(mockClient.post(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
        body: json.encode(<String, String>{'email': 'email', 'password': 'password'}),
      ));
    });

    test("should call login Method with user obj as a response", () async {
      callSuccess200();
      final result = await authRemoteDataImpl.login('email', 'password');
      expect(result, user);
    });

    test("should throw exception when the statues code of http.get does not equal 200 (success)", () async {
      when(mockClient.post(
        any,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
        body: json.encode(<String, String>{'email': 'email', 'password': 'password'}),
      )).thenAnswer((_) async => http.Response(fixture('cached_user_data.json'), 500,
          headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'}));

      final result = authRemoteDataImpl.login;
      expect(() => result('email', 'password'), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
