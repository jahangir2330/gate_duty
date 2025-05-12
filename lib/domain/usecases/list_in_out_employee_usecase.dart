import 'package:gipms/core/error/failures.dart'; // Import your Failure classes
import 'package:gipms/core/usecase/noparams.dart';
import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/source/user_service.dart';
//import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class ListInOutEmployeeUseCase
    implements UseCase<Either<Failure, List<EmployeeInOutEntity>>, NoParams> {
  @override
  Future<Either<Failure, List<EmployeeInOutEntity>>> call(
      {NoParams? param}) async {
    final currentUser = UserService().currentUser;
    final employeeInOut = EmployeeInOutEntity(
      // inbyusername: currentUser?.username, // Uncomment if needed and available in the entity
      gateid: currentUser?.gateid,
      pageSize: 100,
      currentPage: 1,
      sortexpression: 'InTime DESC',
    );

    try {
      final result =
          await sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
      return result.fold(
        (failure) => Left(
            failure), // If repository returns Either<Failure, List<EmployeeInOutEntity>>
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(
          message: e.toString())); // Wrap any exceptions in a Failure
    }
  }
}

// import 'package:gipms/core/usecase/usecase.dart';
// import 'package:gipms/data/source/user_service.dart';
// import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
// import 'package:gipms/domain/entities/employee_in_out_entity.dart';
// import 'package:gipms/domain/repository/in_out_employee_repository.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:dartz/dartz.dart';

// class ListInOutEmployeeUseCase
//     implements UseCase<Either, InOutEmployeeReqParams> {
//   @override
//   Future<Either> call({InOutEmployeeReqParams? param}) async {
//     final currentUser = UserService().currentUser;
//     EmployeeInOutEntity employeeInOut = EmployeeInOutEntity();
//     //employeeInOut.inbyusername = currentUser?.username;
//     employeeInOut.gateid = currentUser?.gateid;
//     employeeInOut.pageSize = 100;
//     employeeInOut.currentPage = 1;
//     employeeInOut.SortExpression = 'InTime DESC';
//     return sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
//   }
// }
