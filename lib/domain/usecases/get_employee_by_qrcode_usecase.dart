import 'package:gipms/core/error/failures.dart'; // Import your Failure classes
import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/domain/entities/employee_entity.dart'; // Assuming your repository returns this
import 'package:gipms/domain/repository/employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetEmployeeByQrCodeUseCase
    implements UseCase<Either<Failure, EmployeeEntity>, GetEmployeeReqParams> {
  @override
  Future<Either<Failure, EmployeeEntity>> call(
      {GetEmployeeReqParams? param}) async {
    try {
      final result = await sl<EmployeeRepository>().getEmployee(param!);
      return result.fold(
        (failure) => Left(failure),
        (employee) => Right(employee),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
