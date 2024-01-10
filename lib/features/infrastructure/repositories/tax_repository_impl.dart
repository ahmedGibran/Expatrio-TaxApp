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
  Future<Either<Failure, Tax>>? getTaxData() async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Tax? tax = await taxRemoteData.getTaxData();
        if (tax != null) {
          await taxLocalData.cacheTaxData(tax);
        }
        return right(tax!);
      } on ServerException {
        return left(const ServerFailure(message: 'Internal Server Error while getTaxData'));
      }
    } else {
      try {
        final Tax? tax = await taxLocalData.getTaxData();
        return right(tax!);
      } on CacheException {
        return left(const CacheFailure(message: 'Internal Cache Error while getTaxData'));
      }
    }
  }

  @override
  Future<Either<Failure, void>>? updateTaxData(Tax tax) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        await taxRemoteData.updateTaxData(tax);
        await taxLocalData.cacheTaxData(tax);
        return right(null);
      } on ServerException {
        return left(const ServerFailure(message: 'Internal Server Error while updateTaxData'));
      }
    } else {
      return left(const ServerFailure(message: 'No internet connection'));
    }
  }
}
