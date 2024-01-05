import 'package:equatable/equatable.dart';

// To handle message error for fetch data errors with dartZ
class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  // The list of properties that will be used to determine whether two instances are equal, supported from Equatable
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message}) : super(message: message);
}

class CacheFailure extends Failure {
  final String message;
  const CacheFailure({required this.message}) : super(message: message);
}
