import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/source/user_service.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

// class OutEmployeeUseCase implements UseCase<Either, InOutEmployeeReqParams> {
//   @override
//   Future<Either> call({InOutEmployeeReqParams? param}) async {
//     final currentUser = UserService().currentUser;
//     EmployeeInOutEntity employeeInOut = EmployeeInOutEntity();
//     employeeInOut.requestemployeeid = -99999;
//     //int.parse(param!.requestemployeeid);
//     employeeInOut.inbyusername = currentUser?.username;
//     employeeInOut.gateid = currentUser?.gateid;
//     employeeInOut.outtime = DateTime.now();
//     employeeInOut.inbymacaddress = "Mobile App";
//     return sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
//   }
// }
class OutEmployeeUseCase implements UseCase<Either, StringIdReqParams> {
  @override
  Future<Either> call({StringIdReqParams? param}) async {
    final currentUser = UserService().currentUser;
    InOutEmployeeReqParams employeeInOut = InOutEmployeeReqParams(
        requestemployeeid: int.parse(param!.idAsString),
        inbyusername: currentUser?.username,
        gateid: currentUser?.gateid,
        outtime: DateTime.now(),
        outbymacaddress: "Mobile App");
    return sl<InOutEmployeeRepository>().outEmployee(employeeInOut);
  }
}
