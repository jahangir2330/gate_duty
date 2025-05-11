import 'package:dartz/dartz.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';

abstract class InOutEmployeeRepository {
  Future<Either> listInOutEmployee(EmployeeInOutEntity employeeInOut);
  Future<Either> inEmployee(InOutEmployeeReqParams employeeInOut);
  Future<Either> outEmployee(InOutEmployeeReqParams employeeInOut);
}
