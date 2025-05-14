import 'package:gipms/data/viewmodels/signin_req_params.dart';
import 'package:gipms/data/viewmodels/signup_req_params.dart';
import 'package:dartz/dartz.dart';
import 'package:gipms/core/error/failures.dart'; // Import your Failure class
import 'package:gipms/domain/entities/user_entity.dart'; // Import your UserEntity class

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signup(SignupReqParams signupReq);
  Future<Either<Failure, UserEntity>> signin(SigninReqParams signinReq);
  Future<bool> isLoggedIn();
  Future<Either<Failure, UserEntity>>
      getUser(); // Assuming getUser returns a UserEntity or Failure
  Future<Either<Failure, Unit>>
      logout(); // Assuming logout returns Unit on success or Failure
}
// import 'package:gipms/data/viewmodels/signin_req_params.dart';
// import 'package:gipms/data/viewmodels/signup_req_params.dart';
// import 'package:dartz/dartz.dart';

// abstract class AuthRepository {
//   Future<Either> signup(SignupReqParams signupReq);
//   Future<Either> signin(SigninReqParams signinReq);
//   Future<bool> isLoggedIn();
//   Future<Either> getUser();
//   Future<Either> logout();
// }
