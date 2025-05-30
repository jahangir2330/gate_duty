import 'package:gipms/core/error/failures.dart'; // Import your Failure classes
import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/source/user_service.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class InEmployeeUseCase
    implements UseCase<Either<Failure, Unit>, IdAsReqParams> {
  @override
  Future<Either<Failure, Unit>> call({IdAsReqParams? param}) async {
    final currentUser = UserService().currentUser;
    final employeeInOut = InOutEmployeeReqParams(
      requestemployeeid: param!.idParam,
      inbyusername: currentUser?.username,
      gateid: currentUser?.gateid,
      intime: DateTime.now(),
      inbymacaddress: "Mobile App",
    );

    try {
      final result =
          await sl<InOutEmployeeRepository>().inEmployee(employeeInOut);
      return result.fold(
        (failure) => Left(failure),
        (_) => Right(
            unit), // Assuming a successful 'in' operation doesn't return data
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
// import 'package:gipms/core/usecase/usecase.dart';
// import 'package:gipms/data/source/user_service.dart';
// import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
// import 'package:gipms/domain/repository/in_out_employee_repository.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:dartz/dartz.dart';

// class InEmployeeUseCase implements UseCase<Either, IdAsReqParams> {
//   @override
//   Future<Either> call({IdAsReqParams? param}) async {
//     final currentUser = UserService().currentUser;
//     InOutEmployeeReqParams employeeInOut = InOutEmployeeReqParams(
//         requestemployeeid: param!.idParam,
//         inbyusername: currentUser?.username,
//         gateid: currentUser?.gateid,
//         intime: DateTime.now(),
//         inbymacaddress: "Mobile App");
//     return sl<InOutEmployeeRepository>().inEmployee(employeeInOut);
//   }
// }
