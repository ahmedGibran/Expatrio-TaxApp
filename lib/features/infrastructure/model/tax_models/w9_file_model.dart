import 'package:expatrio_tax_task/features/features.dart';

class W9FileModel extends W9File {
  const W9FileModel({
    required int id,
    required DateTime? createdAt,
    required DateTime? modifiedAt,
    required String fileName,
    required String? author,
    required String? state,
    required String? field,
    required String? label,
    required String? description,
    required bool invalid,
    required String dataType,
    required String fileUrl,
  }) : super(
          id: id,
          createdAt: createdAt,
          modifiedAt: modifiedAt,
          fileName: fileName,
          author: author,
          state: state,
          field: field,
          label: label,
          description: description,
          invalid: invalid,
          dataType: dataType,
          fileUrl: fileUrl,
        );

  factory W9FileModel.fromJson(Map<String, dynamic> jsonData) {
    return W9FileModel(
      id: jsonData['id'],
      createdAt: DateTime.tryParse(jsonData['createdAt']),
      modifiedAt: DateTime.tryParse(jsonData['modifiedAt']),
      fileName: jsonData['fileName'],
      author: jsonData['author'],
      state: jsonData['state'],
      field: jsonData['field'],
      label: jsonData['label'],
      description: jsonData['description'],
      invalid: jsonData['invalid'],
      dataType: jsonData['dataType'],
      fileUrl: jsonData['fileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'modifiedAt': modifiedAt?.toIso8601String(),
      'fileName': fileName,
      'author': author,
      'state': state,
      'field': field,
      'label': label,
      'description': description,
      'invalid': invalid,
      'dataType': dataType,
      'fileUrl': fileUrl,
    };
  }
}
