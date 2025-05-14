import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/core/utils/user_and_locale_service.dart';
import 'package:gipms/domain/usecases/get_employee_by_qrcode_usecase.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/service_locator.dart';
import 'view_employee_state.dart';

class ViewEmployeeCubit extends Cubit<ViewEmployeeState> {
  final UserAndLocaleService userAndLocaleService; // Add this

  ViewEmployeeCubit(this.userAndLocaleService)
      : super(ViewEmployeeInitial()); // Modify this

  Future<void> fetchEmployeeByQrCode(String qrcode) async {
    emit(ViewEmployeeLoading());
    //final UserAndLocaleService userAndLocaleService; // Remove this
    final Locale currentLocale =
        await userAndLocaleService.getCurrentLocale(); // Get the locale here.

    var apiculture = currentLocale.languageCode;
    final useCase = sl<GetEmployeeByQrCodeUseCase>();
    final params = GetEmployeeReqParams(
        qrcode: qrcode, apiculture: apiculture); // Use apiculture
    final result = await useCase(param: params);

    result.fold(
      (failure) => emit(ViewEmployeeError(
          message: failure.toString())), // Handle failure properly
      (employee) => emit(ViewEmployeeLoaded(
          employee:
              employee)), // Stoped by Jahangir:  employee: employee as EmployeeEntity)),
    );
  }

  Future<void> fetchEmployeeByRequestEmployeeId(int requestemployeeid) async {
    emit(ViewEmployeeLoading());
    final Locale currentLocale = await userAndLocaleService.getCurrentLocale();
    final useCase = sl<GetEmployeeByQrCodeUseCase>();
    final params = GetEmployeeReqParams(
        requestemployeeid: requestemployeeid,
        apiculture: currentLocale.languageCode);
    final result = await useCase(param: params);

    result.fold(
      (failure) => emit(ViewEmployeeError(
          message: failure.toString())), // Handle failure properly
      (employee) => emit(ViewEmployeeLoaded(
          employee:
              employee)), // Stoped by Jahangir:  employee: employee as EmployeeEntity)),
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
