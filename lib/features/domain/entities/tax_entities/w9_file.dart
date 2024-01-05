import 'package:equatable/equatable.dart';

class W9File extends Equatable {
  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String fileName;
  final String? author;
  final String? state;
  final String? field;
  final String? label;
  final String? description;
  final bool invalid;
  final String dataType;
  final String fileUrl;

  const W9File({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.fileName,
    required this.author,
    required this.field,
    required this.label,
    required this.description,
    required this.state,
    required this.dataType,
    required this.fileUrl,
    required this.invalid,
  });

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [
        id,
        createdAt,
        modifiedAt,
        fileName,
        author,
        field,
        label,
        description,
        state,
        dataType,
        fileUrl,
        invalid
      ];
}
