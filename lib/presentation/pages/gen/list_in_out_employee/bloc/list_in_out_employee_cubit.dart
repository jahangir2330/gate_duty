// lib/presentation/pages/employee/bloc/employee_list_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/core/usecase/noparams.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/usecases/list_in_out_employee_usecase.dart';
import 'package:gipms/core/usecase/usecase.dart'; // Import NoParams
part 'list_in_out_employee_state.dart';

class ListInOutEmployeeCubit extends Cubit<ListInOutEmployeeState> {
  final ListInOutEmployeeUseCase _listInOutEmployeeUseCase;

  ListInOutEmployeeCubit(this._listInOutEmployeeUseCase)
      : super(ListInOutEmployeeInitial());

  Future<void> fetchEmployees() async {
    emit(ListInOutEmployeeLoading());
    final result = await _listInOutEmployeeUseCase.call(
        param: NoParams()); // Pass NoParams as the parameter

    result.fold(
      (failure) => emit(ListInOutEmployeeError(failure.message)),
      (employees) => emit(ListInOutEmployeeLoaded(employees)),
    );
  }
}
// // lib/presentation/pages/employee/bloc/employee_list_cubit.dart

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gipms/domain/entities/employee_in_out_entity.dart';
// import 'package:gipms/domain/usecases/list_in_out_employee_usecase.dart';
// part 'list_in_out_employee_state.dart';

// class ListInOutEmployeeCubit extends Cubit<ListInOutEmployeeState> {
//   final ListInOutEmployeeUseCase _listInOutEmployeeUseCase;

//   ListInOutEmployeeCubit(this._listInOutEmployeeUseCase)
//       : super(ListInOutEmployeeInitial());

//   Future<void> fetchEmployees() async {
//     emit(ListInOutEmployeeLoading());
//     final result = await _listInOutEmployeeUseCase
//         .call(); // You might need to adjust the call based on your use case

//     result.fold(
//       (failure) => emit(ListInOutEmployeeError(failure.message)),
//       (employees) => emit(ListInOutEmployeeLoaded(employees)),
//     );
//   }
// }
