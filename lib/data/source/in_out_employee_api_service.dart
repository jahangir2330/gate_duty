import 'dart:convert';

import 'package:gipms/core/constants/api_urls.dart';
import 'package:gipms/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

abstract class InOutEmployeeApiService {
  Future<Either> listInOutEmployee(EmployeeInOutEntity employeeReq);
  Future<Either> inEmployee(InOutEmployeeReqParams employeeReq);
  Future<Either> outEmployee(InOutEmployeeReqParams employeeReq);
}

class InOutEmployeeApiServiceImpl extends InOutEmployeeApiService {
  @override
  Future<Either> listInOutEmployee(EmployeeInOutEntity employeeInOut) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().post(ApiUrls.employeeinoutlist,
          data: jsonEncode(employeeInOut.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> inEmployee(InOutEmployeeReqParams employeeInOut) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().post(ApiUrls.employeein,
          data: jsonEncode(employeeInOut.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> outEmployee(InOutEmployeeReqParams employeeInOut) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().post(ApiUrls.employeeout,
          data: jsonEncode(employeeInOut.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
