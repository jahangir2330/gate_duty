import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class OutEmployeeUseCase implements UseCase<Either, InOutEmployeeReqParams> {
  @override
  Future<Either> call({InOutEmployeeReqParams? param}) async {
    EmployeeInOutEntity employeeInOut = EmployeeInOutEntity();
    employeeInOut.requestemployeeid = int.parse(param!.requestemployeeid);
    //employeeInOut.inbyusername = loggedinUser.username;
    employeeInOut.outtime = DateTime.now();
    employeeInOut.inbymacaddress = "Mobile App";
    return sl<InOutEmployeeRepository>().outEmployee(employeeInOut);
  }
}
