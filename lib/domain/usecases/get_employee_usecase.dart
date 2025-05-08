import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/domain/repository/employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetEmployeeUseCase implements UseCase<Either, GetEmployeeReqParams> {
  @override
  Future<Either> call({GetEmployeeReqParams? param}) async {
    // final currentUser = UserService().currentUser;
    // print(currentUser?.username);
    return sl<EmployeeRepository>().getEmployee(param!);
  }
}
