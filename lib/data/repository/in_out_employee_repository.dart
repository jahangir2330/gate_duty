import 'package:gipms/data/source/in_out_employee_api_service.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InOutEmployeeRepositoryImpl extends InOutEmployeeRepository {
  @override
  Future<Either> inEmployee(InOutEmployeeReqParams employeeReq) async {
    Either result = await sl<InOutEmployeeApiService>().inEmployee(employeeReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      var userEntity = EmployeeInOutEntity.fromJson(response.data);

      return Right(userEntity);
    });
  }

  @override
  Future<Either> outEmployee(InOutEmployeeReqParams employeeReq) async {
    Either result =
        await sl<InOutEmployeeApiService>().outEmployee(employeeReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      var userEntity = EmployeeInOutEntity.fromJson(response.data);

      return Right(userEntity);
    });
  }
}
