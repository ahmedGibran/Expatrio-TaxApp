import 'package:expatrio_tax_task/features/features.dart';

class UserModel extends User {
  const UserModel({
    required int userId,
    required String accessToken,
    required DateTime? accessTokenExpiresAt,
    required String userRole,
    required bool xpm,
    required UserSubject subject,
    required int maxAgeSeconds,
  }) : super(
            userId: userId,
            accessToken: accessToken,
            accessTokenExpiresAt: accessTokenExpiresAt,
            userRole: userRole,
            xpm: xpm,
            subject: subject,
            maxAgeSeconds: maxAgeSeconds);

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      userId: jsonData['userId'],
      accessToken: jsonData['accessToken'],
      accessTokenExpiresAt: DateTime.tryParse(jsonData['accessTokenExpiresAt']),
      userRole: jsonData['userRole'],
      xpm: jsonData['xpm'],
      subject: UserSubjectModel.fromJson(jsonData['subject']),
      maxAgeSeconds: jsonData['maxAgeSeconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "accessToken": accessToken,
      "accessTokenExpiresAt": accessTokenExpiresAt?.toIso8601String(),
      "userRole": userRole,
      "xpm": xpm,
      "maxAgeSeconds": maxAgeSeconds,
    };
  }
}
