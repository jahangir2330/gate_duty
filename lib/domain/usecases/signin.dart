import 'package:gipms/core/error/failures.dart';
import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/viewmodels/signin_req_params.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:gipms/domain/repository/auth.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class SigninUseCase
    implements UseCase<Either<Failure, UserEntity>, SigninReqParams> {
  @override
  Future<Either<Failure, UserEntity>> call({SigninReqParams? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
}

// import 'package:gipms/core/usecase/usecase.dart';
// import 'package:gipms/data/viewmodels/signin_req_params.dart';
// import 'package:gipms/domain/repository/auth.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:dartz/dartz.dart';

// class SigninUseCase implements UseCase<Either, SigninReqParams> {
//   @override
//   Future<Either> call({SigninReqParams? param}) async {
//     return sl<AuthRepository>().signin(param!);
//   }
// }
