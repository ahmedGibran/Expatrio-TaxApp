import 'package:equatable/equatable.dart';

class TaxResidence extends Equatable {
  final String id;
  final String country;

  const TaxResidence({
    required this.id,
    required this.country,
  });

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [id, country];
}
