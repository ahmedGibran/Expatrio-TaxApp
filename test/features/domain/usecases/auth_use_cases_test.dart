import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

// flutter test test/features/domain/usecases/auth_use_cases_test.dart
void main() {
  late AuthUseCases authUseCases;
  late MockAuthRepository mockAuthRepository;
  // this function it will be start before test functions work
  setUpAll(() {
    // define instances
    mockAuthRepository = MockAuthRepository();
    // set mock mockAuthRepository value to the authUseCases instance of AuthUseCases
    authUseCases = AuthUseCases(authRepository: mockAuthRepository);
  });

  User user = User(
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

  test('should be check the login function passed with right return', () async {
    when(mockAuthRepository.login('email@email.com', 'password'))
        .thenAnswer((_) async => Right(user));

    final result = await authUseCases.login('email@email.com', 'password');
    expect(result, Right(user));

    verify(mockAuthRepository.login('email@email.com', 'password'));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should be check the login function fail with left return', () async {
    when(mockAuthRepository.login('email', 'password'))
        .thenAnswer((_) async => const Left(Failure(message: 'fails')));

    final result = await authUseCases.login('email', 'password');
    expect(result, const Left(Failure(message: 'fails')));

    verify(mockAuthRepository.login('email', 'password'));
    verifyNoMoreInteractions(mockAuthRepository);
  }); //end of authUseCases test
}
