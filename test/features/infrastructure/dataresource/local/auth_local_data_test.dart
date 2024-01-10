import 'dart:convert';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_local_data_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
//flutter test test/features/infrastructure/dataresource/local/auth_local_data_test.dart
void main() {
  late AuthLocalDataImpl authLocalDataImpl;
  late MockFlutterSecureStorage mockStorage;

  setUpAll(() {
    mockStorage = MockFlutterSecureStorage();
    authLocalDataImpl = AuthLocalDataImpl(storage: mockStorage);
  });

  group('authLocalDataImpl test group', () {
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

    test("should call cacheUserData Method and store the user obj as string", () async {
      await authLocalDataImpl.cacheUserData(user);
      verify(mockStorage.write(key: CACHED_USER_DATA, value: jsonEncode(user.toJson())));
    });

    test("should call getUserData Method and return the stored user obj", () async {
      when(mockStorage.read(key: CACHED_USER_DATA)).thenAnswer((_) async => jsonEncode(user.toJson()));
      final result = await authLocalDataImpl.getUserData();
      verify(mockStorage.read(key: CACHED_USER_DATA));
      expect(result, user);
    });
  });
}
