import 'package:dartz/dartz.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';

abstract class InOutEmployeeRepository {
  Future<Either> inEmployee(EmployeeInOutEntity employeeInOut);
  Future<Either> outEmployee(EmployeeInOutEntity signinReq);
}
