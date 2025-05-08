import 'package:auth/data/viewmodels/getemployee_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class EmployeeRepository {
  Future<Either> getEmployee(GetEmployeeReqParams signinReq);
}
