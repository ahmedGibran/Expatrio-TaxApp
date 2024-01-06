import 'package:expatrio_tax_task/features/features.dart';

class TaxModel extends Tax {
  const TaxModel({
    required String? usTaxId,
    required bool? usPerson,
    required TaxResidence primaryTaxResidence,
    required List<TaxResidence> secondaryTaxResidence,
    required int? w9FileId,
    required W9File? w9File,
  }) : super(
          usTaxId: usTaxId,
          usPerson: usPerson,
          primaryTaxResidence: primaryTaxResidence,
          secondaryTaxResidence: secondaryTaxResidence,
          w9FileId: w9FileId,
          w9File: w9File,
        );

  factory TaxModel.fromJson(Map<String, dynamic> jsonData) {
    final List<TaxResidence> sTaxResidences = [];
    if (jsonData['secondaryTaxResidence'] != null) {
      for (var item in jsonData['secondaryTaxResidence']) {
        sTaxResidences.add(TaxResidenceModel.fromJson(item));
      }
    }

    return TaxModel(
      usTaxId: jsonData['usTaxId'],
      usPerson: jsonData['usPerson'],
      primaryTaxResidence:
          TaxResidenceModel.fromJson(jsonData['primaryTaxResidence']),
      secondaryTaxResidence: sTaxResidences,
      w9FileId: jsonData['w9FileId'],
      w9File: W9FileModel.fromJson(jsonData['w9File']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usTaxId': usTaxId,
      'usPerson': usPerson,
      'primaryTaxResidence':
          (primaryTaxResidence as TaxResidenceModel).toJson(),
      'secondaryTaxResidence': [
        for (var taxResidenceItem in secondaryTaxResidence)
          (taxResidenceItem as TaxResidenceModel).toJson(),
      ],
      'w9FileId': w9FileId,
    };
  }
}
