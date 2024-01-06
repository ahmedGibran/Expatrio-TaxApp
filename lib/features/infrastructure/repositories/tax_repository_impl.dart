import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';

class TaxRepositoryImpl extends TaxRepository {
  final NetworkInfo networkInfo;
  final TaxRemoteData taxRemoteData;
  final TaxLocalData taxLocalData;
  TaxRepositoryImpl({
    required this.networkInfo,
    required this.taxRemoteData,
    required this.taxLocalData,
  });

  @override
  Future<Either<Failure, Tax>>? getTaxData() {}

  @override
  Future<Either<Failure, void>>? updateTaxData(Tax tax) {}
}
