import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/domain/repository/auth.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<AuthRepository>().getUser();
  }
}
