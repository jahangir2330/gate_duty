import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class InEmployeeUseCase implements UseCase<Either, InOutEmployeeReqParams> {
  @override
  Future<Either> call({InOutEmployeeReqParams? param}) async {
    return sl<InOutEmployeeRepository>().outEmployee(param!);
  }
}
