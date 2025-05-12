import 'package:gipms/domain/entities/employee_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/domain/usecases/get_employee_usecase.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/service_locator.dart';
import 'view_employee_state.dart';

class ViewEmployeeCubit extends Cubit<ViewEmployeeState> {
  ViewEmployeeCubit() : super(ViewEmployeeInitial());

  Future<void> fetchEmployeeByQrCode(String qrcode) async {
    emit(ViewEmployeeLoading());
    final useCase = sl<GetEmployeeByQrCodeUseCase>();
    final params = GetEmployeeReqParams(qrcode: qrcode);
    final result = await useCase(param: params);

    result.fold(
      (failure) => emit(ViewEmployeeError(
          message: failure.toString())), // Handle failure properly
      (employee) => emit(ViewEmployeeLoaded(
          employee: employee as EmployeeEntity)), // Cast the result
    );
  }

  Future<void> fetchEmployeeByRequestEmployeeId(int requestemployeeid) async {
    print(requestemployeeid);
    emit(ViewEmployeeLoading());
    final useCase = sl<GetEmployeeByQrCodeUseCase>();
    final params = GetEmployeeReqParams(requestemployeeid: requestemployeeid);
    final result = await useCase(param: params);

    result.fold(
      (failure) => emit(ViewEmployeeError(
          message: failure.toString())), // Handle failure properly
      (employee) => emit(ViewEmployeeLoaded(
          employee: employee as EmployeeEntity)), // Cast the result
    );
  }

  // Combined fetchEmployee method that checks the parameter type
  Future<void> fetchEmployee(String parameter) async {
    if (int.tryParse(parameter) != null) {
      await fetchEmployeeByRequestEmployeeId(int.parse(parameter));
    } else {
      await fetchEmployeeByQrCode(parameter);
    }
  }
}
