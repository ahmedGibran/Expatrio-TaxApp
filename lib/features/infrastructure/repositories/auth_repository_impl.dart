import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteData authRemoteData;
  final AuthLocalData authLocalData;
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authRemoteData,
    required this.authLocalData,
  });

  @override
  Future<Either<Failure, User>>? login(String email, String password) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final User? user = await authRemoteData.login(email, password);
        if (user != null) {
          await authLocalData.cacheUserData(user);
        }
        return right(user!);
      } on ServerException {
        return left(const ServerFailure(message: 'Internal Server Error while login'));
      }
    } else {
      try {
        final User? user = await authLocalData.getUserData();
        return right(user!);
      } on CacheException {
        return left(const CacheFailure(message: 'Internal Cache Error while login'));
      }
    }
  }
}
