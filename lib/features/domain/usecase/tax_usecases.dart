import 'package:dartz/dartz.dart';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';

class TaxUseCases {
  final TaxRepository taxRepository;
  const TaxUseCases({required this.taxRepository});

  Future<Either<Failure, Tax>?> getTaxData() async {
    return taxRepository.getTaxData();
  }

  Future<Either<Failure, void>?> updateTaxData(Tax tax) async {
    return taxRepository.updateTaxData(tax);
  }
}
