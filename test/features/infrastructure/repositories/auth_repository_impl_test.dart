import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, AuthRemoteData, AuthLocalData])
//flutter test test/features/infrastructure/repositories/auth_repository_impl_test.dart
void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockAuthRemoteData mockAuthRemoteData;
  late MockAuthLocalData mockAuthLocalData;
  late User user;

  setUpAll(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthRemoteData = MockAuthRemoteData();
    mockAuthLocalData = MockAuthLocalData();
    authRepositoryImpl = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      authRemoteData: mockAuthRemoteData,
      authLocalData: mockAuthLocalData,
    );
    user = User(
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
  });

  group("AuthRepositoryImpl test group when device is online", () {
    setUpAll(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockAuthRemoteData.login('email', 'password')).thenAnswer((_) async => user);
      when(mockAuthLocalData.getUserData()).thenAnswer((_) async => user);
      when(mockAuthLocalData.cacheUserData(user)).thenAnswer((_) async => returnsNormally);
    });

    test("Should to check the device is online or not", () async {
      await authRepositoryImpl.login('email', 'password');
      verify(mockNetworkInfo.isConnected);
    });

    test("should call cache user data when remote data is received", () async {
      await authRepositoryImpl.login('email', 'password');
      verify(authRepositoryImpl.login('email', 'password'));
      verify(mockAuthLocalData.cacheUserData(user));
    });
  });

  group("AuthRepositoryImpl test group when device is offline", () {
    setUpAll(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockAuthLocalData.getUserData()).thenAnswer((_) async => user);
    });

    test("Should to check the device is online or not", () async {
      await authRepositoryImpl.login('email', 'password');
      verify(mockNetworkInfo.isConnected);
    });

    test("should call cache user data when remote data is received", () async {
      await authRepositoryImpl.login('email', 'password');
      verify(authRepositoryImpl.login('email', 'password'));
      verify(mockAuthLocalData.getUserData());
    });
  });
}
