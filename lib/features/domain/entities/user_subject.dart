import 'package:equatable/equatable.dart';

class UserSubject extends Equatable {
  final int userId;
  final String userUuid;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String role;
  final bool isAdmin;

  const UserSubject({
    required this.userId,
    required this.userUuid,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isAdmin,
  });

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props =>
      [userId, userUuid, firstName, lastName, fullName, email, role, isAdmin];
}
