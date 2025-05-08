import 'package:gipms/core/constants/api_urls.dart';
import 'package:gipms/core/network/dio_client.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

abstract class InOutEmployeeApiService {
  Future<Either> inEmployee(InOutEmployeeReqParams employeeReq);
  Future<Either> outEmployee(InOutEmployeeReqParams employeeReq);
}

class InOutEmployeeApiServiceImpl extends InOutEmployeeApiService {
  @override
  Future<Either> inEmployee(InOutEmployeeReqParams employeeReq) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().get(ApiUrls.employeein,
          queryParameters: {'params': employeeReq.requestemployeeid},
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> outEmployee(InOutEmployeeReqParams employeeReq) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await sl<DioClient>().get(ApiUrls.employeeout,
          queryParameters: {'params': employeeReq.requestemployeeid},
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
