import 'package:gipms/core/error/failures.dart'; // Import your Failure classes
import 'package:gipms/core/usecase/noparams.dart';
import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/domain/entities/user_entity.dart'; // Assuming your repository returns this
import 'package:gipms/domain/repository/auth.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase implements UseCase<Either<Failure, UserEntity>, NoParams> {
  @override
  Future<Either<Failure, UserEntity>> call({NoParams? param}) async {
    try {
      final result = await sl<AuthRepository>().getUser();
      return result.fold(
        (failure) =>
            Left(failure), // If repository returns Either<Failure, UserEntity>
        (user) => Right(user),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
// import 'package:gipms/core/usecase/usecase.dart';
// import 'package:gipms/domain/repository/auth.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:dartz/dartz.dart';

// class GetUserUseCase implements UseCase<Either, dynamic> {
//   @override
//   Future<Either> call({dynamic param}) async {
//     return sl<AuthRepository>().getUser();
//   }
// }
