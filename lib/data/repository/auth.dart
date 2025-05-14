import 'package:gipms/core/error/failures.dart';
import 'package:gipms/data/source/user_service.dart';
import 'package:gipms/data/viewmodels/signin_req_params.dart';
import 'package:gipms/data/source/auth_api_service.dart';
import 'package:gipms/data/source/auth_local_service.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:gipms/domain/repository/auth.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodels/signup_req_params.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, UserEntity>> signin(SigninReqParams signinReq) async {
    Either<Failure, Response> result =
        await sl<AuthApiService>().signin(signinReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', response.data['accessToken']);
      // Assuming your signin API returns a UserEntity or necessary data to create one
      // You might need to adjust this based on your actual API response
      try {
        Either<Failure, Response> result = await sl<AuthApiService>().getUser();
        return result.fold((error) {
          return Left(error);
        }, (data) {
          Response response = data;
          try {
            final userEntity = UserEntity.fromJson(response.data['_owin_User']);
            UserService().setUser(userEntity);
            return Right(userEntity);
          } catch (e) {
            return Left(const ServerFailure('Failed to parse user data'));
          }
        });
      } catch (e) {
        return Left(
            const ServerFailure('Failed to parse user data after signin'));
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signup(SignupReqParams signupReq) async {
    Either<Failure, Response> result =
        await sl<AuthApiService>().signup(signupReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('token', response.data['token']);
      // Assuming your signup API returns a UserEntity or necessary data to create one
      // You might need to adjust this based on your actual API response
      try {
        final userEntity = UserEntity.fromJson(
            response.data['_owin_User']); // Adjust key as needed
        return Right(userEntity);
      } catch (e) {
        return Left(
            const ServerFailure('Failed to parse user data after signup'));
      }
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    Either<Failure, Response> result = await sl<AuthApiService>().getUser();
    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      try {
        final userEntity = UserEntity.fromJson(response.data['_owin_User']);
        UserService().setUser(userEntity);
        return Right(userEntity);
      } catch (e) {
        return Left(const ServerFailure('Failed to parse user data'));
      }
    });
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    final result = await sl<AuthLocalService>().logout();
    return result.fold(
      (error) => Left(error),
      (success) => Right(unit),
    );
  }
}

// import 'package:gipms/data/source/user_service.dart';
// import 'package:gipms/data/viewmodels/signin_req_params.dart';
// import 'package:gipms/data/source/auth_api_service.dart';
// import 'package:gipms/data/source/auth_local_service.dart';
// import 'package:gipms/domain/entities/user_entity.dart';
// import 'package:gipms/domain/repository/auth.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../viewmodels/signup_req_params.dart';

// class AuthRepositoryImpl extends AuthRepository {
//   @override
//   Future<Either> signup(SignupReqParams signupReq) async {
//     Either result = await sl<AuthApiService>().signup(signupReq);
//     return result.fold((error) {
//       return Left(error);
//     }, (data) async {
//       Response response = data;
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       sharedPreferences.setString('token', response.data['token']);
//       return Right(response);
//     });
//   }

//   @override
//   Future<bool> isLoggedIn() async {
//     return await sl<AuthLocalService>().isLoggedIn();
//   }

//   @override
//   Future<Either> getUser() async {
//     Either result = await sl<AuthApiService>().getUser();
//     return result.fold((error) {
//       return Left(error);
//     }, (data) {
//       Response response = data;

//       var userEntity = UserEntity.fromJson(response.data['_owin_User']);
//       UserService().setUser(userEntity);

//       return Right(userEntity);
//     });
//   }

//   @override
//   Future<Either> logout() async {
//     return await sl<AuthLocalService>().logout();
//   }

//   @override
//   Future<Either> signin(SigninReqParams signinReq) async {
//     Either result = await sl<AuthApiService>().signin(signinReq);
//     return result.fold((error) {
//       return Left(error);
//     }, (data) async {
//       Response response = data;
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       sharedPreferences.setString('token', response.data['accessToken']);
//       return Right(response);
//     });
//   }
// }
