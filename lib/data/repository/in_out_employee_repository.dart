import 'package:gipms/data/source/in_out_employee_api_service.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InOutEmployeeRepositoryImpl extends InOutEmployeeRepository {
  @override
  Future<Either> inEmployee(EmployeeInOutEntity employeeInOut) async {
    Either result =
        await sl<InOutEmployeeApiService>().inEmployee(employeeInOut);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      bool returnvalue = false;
      Response response = data;
      if (response.statusCode == 200) {
        returnvalue = true;
      } else {
        returnvalue = false;
      }
      return Right(returnvalue);
    });
  }

  @override
  Future<Either> outEmployee(EmployeeInOutEntity employeeInOut) async {
    Either result =
        await sl<InOutEmployeeApiService>().outEmployee(employeeInOut);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      bool returnvalue = false;
      Response response = data;
      print('response');
      print(response);
      print('response.statusCode');
      print(response.statusCode);
      if (response.statusCode == 200) {
        returnvalue = true;
      } else {
        returnvalue = false;
      }
      return Right(returnvalue);
    });
  }
}
