// lib/presentation/pages/employee/bloc/employee_list_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/usecases/list_in_out_employee_usecase.dart';
part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  final ListInOutEmployeeUseCase
      _listInOutEmployeeUseCase; // Or a specific employee list use case

  EmployeeListCubit(this._listInOutEmployeeUseCase)
      : super(EmployeeListInitial());

  Future<void> fetchEmployees() async {
    emit(EmployeeListLoading());
    final result = await _listInOutEmployeeUseCase
        .call(); // You might need to adjust the call based on your use case

    result.fold(
      (failure) => emit(EmployeeListError(failure.message)),
      (employees) => emit(EmployeeListLoaded(employees)),
    );
  }
}
