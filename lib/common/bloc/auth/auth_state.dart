abstract class AuthState {}

class AppInitialState extends AuthState {}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthLoading
    extends AuthState {} // Optional: For showing loading during logout

class AuthFailure extends AuthState {
  // Optional: For handling logout errors
  final String message;
  AuthFailure(this.message);
}

class LoggedOut extends AuthState {}
