import 'package:equatable/equatable.dart';
import 'package:expatrio_tax_task/features/domain/entities/entities.dart';

class Tax extends Equatable {
  final String? usTaxId;
  final bool? usPerson;
  final TaxResidence primaryTaxResidence;
  final List<TaxResidence> secondaryTaxResidence;
  final int? w9FileId;
  final W9File? w9File;

  const Tax({
    required this.usTaxId,
    required this.usPerson,
    required this.primaryTaxResidence,
    required this.secondaryTaxResidence,
    required this.w9FileId,
    required this.w9File,
  });

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [usTaxId, usPerson, primaryTaxResidence, secondaryTaxResidence, w9FileId, w9File];
}
