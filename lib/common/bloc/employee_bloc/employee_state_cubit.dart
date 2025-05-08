import 'package:auth/domain/entities/employee_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/domain/usecases/get_employee_usecase.dart';
import 'package:auth/data/viewmodels/getemployee_req_params.dart';
import 'package:auth/service_locator.dart';
import 'view_employee_state.dart';

class ViewEmployeeCubit extends Cubit<ViewEmployeeState> {
  ViewEmployeeCubit() : super(ViewEmployeeInitial());

  Future<void> fetchEmployee(String qrcode) async {
    emit(ViewEmployeeLoading());
    final useCase = sl<GetEmployeeUseCase>();
    final params = GetEmployeeReqParams(qrcode: qrcode);
    final result = await useCase(param: params);

    result.fold(
      (failure) => emit(ViewEmployeeError(
          message: failure.toString())), // Handle failure properly
      (employee) => emit(ViewEmployeeLoaded(
          employee: employee as EmployeeEntity)), // Cast the result
    );
  }
}
