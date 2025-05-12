import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/core/usecase/noparams.dart';
//import 'package:gipms/domain/entities/user_entity.dart'; // Import UserEntity
import 'package:gipms/domain/usecases/get_user.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';
import 'package:gipms/service_locator.dart';
//import 'package:dartz/dartz.dart';
//import 'package:gipms/core/error/failures.dart'; // Import Failure

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    final result =
        await sl<GetUserUseCase>().call(param: NoParams()); // Pass NoParams

    result.fold(
      (failure) {
        emit(LoadUserFailure(
            errorMessage: failure.message ?? 'An error occurred'));
      },
      (user) {
        emit(UserLoaded(userEntity: user));
      },
    );
  }
}
// import 'package:gipms/domain/usecases/get_user.dart';
// import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class UserDisplayCubit extends Cubit<UserDisplayState> {
//   UserDisplayCubit() : super(UserLoading());

//   void displayUser() async {
//     var result = await sl<GetUserUseCase>().call();
//     result.fold((error) {
//       emit(LoadUserFailure(errorMessage: error));
//     }, (data) {
//       emit(UserLoaded(userEntity: data));
//     });
//   }
// }
