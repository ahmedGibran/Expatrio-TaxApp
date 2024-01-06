import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';

abstract class TaxRepository {
  Future<Either<Failure, Tax>>? getTaxData();
  Future<Either<Failure, void>>? updateTaxData(Tax tax);
}
