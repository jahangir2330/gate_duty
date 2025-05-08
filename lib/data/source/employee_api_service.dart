import 'dart:convert';

import 'package:auth/core/constants/api_urls.dart';
import 'package:auth/core/network/dio_client.dart';
import 'package:auth/data/viewmodels/getemployee_req_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

abstract class EmployeeApiService {
  Future<Either> getEmployee(GetEmployeeReqParams employeeReq);
}

class EmployeeApiServiceImpl extends EmployeeApiService {
  @override
  Future<Either> getEmployee(GetEmployeeReqParams employeeReq) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().get(ApiUrls.employeedetail,
          queryParameters: {'params': employeeReq.qrcode},
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
