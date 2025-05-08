import 'package:dartz/dartz.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';

abstract class InOutEmployeeRepository {
  Future<Either> inEmployee(InOutEmployeeReqParams signinReq);
  Future<Either> outEmployee(InOutEmployeeReqParams signinReq);
}
