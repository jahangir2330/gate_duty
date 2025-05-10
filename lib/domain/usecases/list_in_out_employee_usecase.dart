import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/source/user_service.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class ListInOutEmployeeUseCase
    implements UseCase<Either, InOutEmployeeReqParams> {
  @override
  Future<Either> call({InOutEmployeeReqParams? param}) async {
    final currentUser = UserService().currentUser;
    EmployeeInOutEntity employeeInOut = EmployeeInOutEntity();
    //employeeInOut.inbyusername = currentUser?.username;
    employeeInOut.gateid = currentUser?.gateid;
    employeeInOut.pageSize = 100;
    employeeInOut.currentPage = 1;
    return sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
  }
}
