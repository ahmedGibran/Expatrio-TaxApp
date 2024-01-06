import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/domain/domain.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>>? login();
}
