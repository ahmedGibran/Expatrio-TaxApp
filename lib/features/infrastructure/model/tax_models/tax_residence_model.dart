import 'package:expatrio_tax_task/features/features.dart';

class TaxResidenceModel extends TaxResidence {
  const TaxResidenceModel({required String id, required String country}) : super(id: id, country: country);

  factory TaxResidenceModel.fromJson(Map<String, dynamic> jsonData) {
    return TaxResidenceModel(id: jsonData['id'], country: jsonData['country']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'country': country};
  }
}
