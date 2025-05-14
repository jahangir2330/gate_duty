import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:gipms/core/constants/api_urls.dart';
import 'package:gipms/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gipms/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodels/signin_req_params.dart';
import '../viewmodels/signup_req_params.dart';
import '../../core/error/failures.dart'; // Import your Failure class

abstract class AuthApiService {
  Future<Either<Failure, Response>> signup(SignupReqParams signupReq);
  Future<Either<Failure, Response>> getUser();
  Future<Either<Failure, Response>> signin(SigninReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<Failure, Response>> signup(SignupReqParams signupReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.register, data: signupReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(
          e.response?.data['message'] ?? 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Response>> signin(SigninReqParams signinReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.login, data: signinReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(
          e.response?.data['message'] ?? 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Response>> getUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      if (token == null) {
        return Left(const LocalStorageFailure('No token found'));
      }
      final jwt = JWT.decode(token.toString());
      final masterUserIdFromToken = jwt.payload['masteruserid'];
      if (masterUserIdFromToken == null) {
        return Left(
            const InvalidTokenFailure('Master user ID not found in token'));
      }
      final masterUserId = jwt.payload['masteruserid'];

      var response = await sl<DioClient>().get(ApiUrls.getuserinfo,
          queryParameters: {'masteruserid': int.parse(masterUserId.toString())},
          options: Options(headers: {'Authorization': 'Bearer $token '}));
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(
          e.response?.data['message'] ?? 'An unexpected error occurred'));
    } catch (e) {
      return Left(const UnexpectedFailure(
          'An unexpected error occurred while fetching user info'));
    }
  }
}
// import 'package:gipms/core/constants/api_urls.dart';
// import 'package:gipms/core/network/dio_client.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../service_locator.dart';
// import '../viewmodels/signin_req_params.dart';
// import '../viewmodels/signup_req_params.dart';

// abstract class AuthApiService {
//   Future<Either> signup(SignupReqParams signupReq);
//   Future<Either> getUser();
//   Future<Either> signin(SigninReqParams signinReq);
// }

// class AuthApiServiceImpl extends AuthApiService {
//   @override
//   Future<Either> signup(SignupReqParams signupReq) async {
//     try {
//       var response =
//           await sl<DioClient>().post(ApiUrls.register, data: signupReq.toMap());

//       return Right(response);
//     } on DioException catch (e) {
//       return Left(e.response!.data['message']);
//     }
//   }

//   @override
//   @override
//   Future<Either> signin(SigninReqParams signinReq) async {
//     try {
//       var response =
//           await sl<DioClient>().post(ApiUrls.login, data: signinReq.toMap());

//       return Right(response);
//     } on DioException catch (e) {
//       return Left(e.response!.data['message']);
//     }
//   }

//   @override
//   Future<Either> getUser() async {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       var token = sharedPreferences.getString('token');

//       if (token == null) {}
//       final jwt = JWT.decode(token.toString());
//       final masterUserIdFromToken = jwt.payload['masteruserid'];
//       if (masterUserIdFromToken == null) {}
//       final masterUserId = jwt.payload['masteruserid'];

//       var response = await sl<DioClient>().get(ApiUrls.getuserinfo,
//           queryParameters: {'masteruserid': int.parse(masterUserId)},
//           options: Options(headers: {'Authorization': 'Bearer $token '}));
//       return Right(response);
//     } on DioException catch (e) {
//       return Left(e.response!.data['message']);
//     }
//   }
// }
