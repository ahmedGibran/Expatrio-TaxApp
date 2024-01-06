import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  const AuthUseCases({required this.authRepository});

  Future<Either<Failure, User>?> login(String email, String password) async {
    return authRepository.login(email, password);
  }
}
