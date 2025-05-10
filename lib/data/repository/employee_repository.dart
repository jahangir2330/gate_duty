import 'package:gipms/data/source/employee_api_service.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/domain/entities/employee_entity.dart';
import 'package:gipms/domain/repository/employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class EmployeeRepositoryImpl extends EmployeeRepository {
  @override
  Future<Either> getEmployee(GetEmployeeReqParams employeeReq) async {
    Either result = await sl<EmployeeApiService>().getEmployee(employeeReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      var userEntity = EmployeeEntity.fromJson(response.data);

      return Right(userEntity);
    });
  }
}
