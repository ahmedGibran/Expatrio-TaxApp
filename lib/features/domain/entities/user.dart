import 'package:equatable/equatable.dart';
import 'entities.dart';

class User extends Equatable {
  final int userId;
  final String accessToken;
  final DateTime accessTokenExpiresAt;
  final String userRole;
  final bool xpm;
  final UserSubject subject;
  final int maxAgeSeconds;

  const User({
    required this.userId,
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.userRole,
    required this.xpm,
    required this.subject,
    required this.maxAgeSeconds,
  });

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [
        userId,
        accessToken,
        accessTokenExpiresAt,
        userRole,
        xpm,
        subject,
        maxAgeSeconds
      ];
}
