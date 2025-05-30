import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeeRepository {
  Future<Either> getEmployee(GetEmployeeReqParams employeeReq);
  //Future<Either> getEmployeeByEmployeeRequestId(
  //  GetEmployeeReqParams employeeReq);
}
