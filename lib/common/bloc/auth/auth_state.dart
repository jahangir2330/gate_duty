// auth_state.dart
import 'package:equatable/equatable.dart';
import 'package:gipms/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppInitialState extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity? user;

  Authenticated({this.user});

  @override
  List<Object?> get props => [user];
}

class UnAuthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// abstract class AuthState {}

// class AppInitialState extends AuthState {}

// class Authenticated extends AuthState {}

// class UnAuthenticated extends AuthState {}

// class AuthLoading
//     extends AuthState {} // Optional: For showing loading during logout

// class AuthFailure extends AuthState {
//   // Optional: For handling logout errors
//   final String message;
//   AuthFailure(this.message);
// }

// class LoggedOut extends AuthState {}
