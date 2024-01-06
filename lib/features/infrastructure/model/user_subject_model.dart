import 'package:expatrio_tax_task/features/domain/domain.dart';

class UserSubjectModel extends UserSubject {
  const UserSubjectModel({
    required int userId,
    required String userUuid,
    required String firstName,
    required String lastName,
    required String fullName,
    required String email,
    required String role,
    required bool isAdmin,
  }) : super(
          userId: userId,
          userUuid: userUuid,
          firstName: firstName,
          lastName: lastName,
          fullName: fullName,
          email: email,
          role: role,
          isAdmin: isAdmin,
        );

  factory UserSubjectModel.fromJson(Map<String, dynamic> jsonData) {
    return UserSubjectModel(
      userId: jsonData['userId'],
      userUuid: jsonData['userUuid'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      fullName: jsonData['fullName'],
      email: jsonData['email'],
      role: jsonData['role'],
      isAdmin: jsonData['isAdmin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userUuid": userUuid,
      "firstName": firstName,
      "lastName": lastName,
      "fullName": fullName,
      "email": email,
      "role": role,
      "isAdmin": isAdmin,
    };
  }
}
