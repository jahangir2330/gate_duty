import 'package:gipms/core/constants/api_urls.dart';
import 'package:gipms/core/network/dio_client.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
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
      var dioClient = sl<DioClient>();
      var headers = Options(headers: {'Authorization': 'Bearer $token'});

      Response response;

      if (employeeReq.qrcode != null) {
        response = await dioClient.get(
          ApiUrls.getEmployeeDetailByUrl,
          queryParameters: {'params': employeeReq.qrcode},
          options: headers,
        );
      } else if (employeeReq.requestemployeeid != null) {
        response = await dioClient.get(
          ApiUrls.getEmployeeDetailByRequestEmployeeId,
          queryParameters: {'params': employeeReq.requestemployeeid},
          options: headers,
        );
      } else {
        return Left("No Parameter Found");
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error occurred');
    }
  }
}
