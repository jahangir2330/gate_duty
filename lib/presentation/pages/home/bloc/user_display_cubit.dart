import 'package:gipms/domain/usecases/get_user.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';
import 'package:gipms/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    var result = await sl<GetUserUseCase>().call();
    result.fold((error) {
      emit(LoadUserFailure(errorMessage: error));
    }, (data) {
      print('data');
      print(data.email);
      emit(UserLoaded(userEntity: data));
    });
  }
}
