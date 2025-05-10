import 'package:gipms/common/bloc/auth/auth_state.dart';
import 'package:gipms/domain/usecases/is_logged_in.dart';
import 'package:gipms/domain/usecases/logout.dart';
import 'package:gipms/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading()); // Optional: Show loading indicator
    final logoutResult = await sl<LogoutUseCase>().call();
    logoutResult.fold(
      (failure) {
        emit(AuthFailure(failure.message)); // Optional: Handle logout failure
      },
      (success) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('authToken');
        emit(
            UnAuthenticated()); // Or emit LoggedOut() - both work for navigation
      },
    );
  }
}
