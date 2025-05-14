import 'package:flutter/material.dart'; // Import for Locale
import 'package:gipms/core/error/failures.dart';
import 'package:gipms/core/usecase/noparams.dart';
import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/core/utils/user_and_locale_service.dart';
import 'package:gipms/domain/entities/employee_in_out_entity.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/service_locator.dart';
import 'package:dartz/dartz.dart';

class ListInOutEmployeeUseCase
    implements UseCase<Either<Failure, List<EmployeeInOutEntity>>, NoParams> {
  final UserAndLocaleService userAndLocaleService;

  ListInOutEmployeeUseCase(this.userAndLocaleService);

  @override
  Future<Either<Failure, List<EmployeeInOutEntity>>> call(
      {NoParams? param}) async {
    final currentUser = userAndLocaleService.currentUser;
    final Locale currentLocale =
        await userAndLocaleService.getCurrentLocale(); // Get the locale here.

    final employeeInOut = EmployeeInOutEntity(
      // inbyusername: currentUser?.username, //  when need filter by current user
      gateid: currentUser?.gateid,
      pageSize: 100,
      currentPage: 1,
      apiculture: currentLocale.languageCode,
      sortexpression: 'InTime DESC',
    );

    try {
      final result =
          await sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}





// class ListInOutEmployeeUseCase
//     implements UseCase<Either<Failure, List<EmployeeInOutEntity>>, NoParams> {
//    final UserAndLocaleService userAndLocaleService; 
//   Future<Locale> _getCurrentLocale() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? savedLocale = prefs.getString('locale');
//     if (savedLocale != null) {
//       return Locale(
//         savedLocale.split('_')[0],
//         savedLocale.split('_').length > 1 ? savedLocale.split('_')[1] : null,
//       );
//     } else {
//       return const Locale('ar'); // Default locale
//     }
//   }

//   @override
//   Future<Either<Failure, List<EmployeeInOutEntity>>> call(
//       {NoParams? param}) async {
//     final currentUser = UserService().currentUser;
//     final Locale currentLocale =
//         await _getCurrentLocale(); // Get the locale here.
//     final employeeInOut = EmployeeInOutEntity(
//       // inbyusername: currentUser?.username, //  when need filter by current user
//       gateid: currentUser?.gateid,
//       pageSize: 100,
//       currentPage: 1,
//       // currentlocal: currentLocale.languageCode, // Pass the language code
//       sortexpression: 'InTime DESC',
//     );

//     try {
//       final result =
//           await sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
//       return result.fold(
//         (failure) => Left(failure),
//         (data) => Right(data),
//       );
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }


// // import 'package:gipms/core/error/failures.dart'; // Import your Failure classes
// // import 'package:gipms/core/usecase/noparams.dart';
// // import 'package:gipms/core/usecase/usecase.dart';
// // import 'package:gipms/data/source/user_service.dart';
// // import 'package:gipms/domain/entities/employee_in_out_entity.dart';
// // import 'package:gipms/domain/repository/in_out_employee_repository.dart';
// // import 'package:gipms/service_locator.dart';
// // import 'package:dartz/dartz.dart';

// // class ListInOutEmployeeUseCase
// //     implements UseCase<Either<Failure, List<EmployeeInOutEntity>>, NoParams> {
// //   @override
// //   Future<Either<Failure, List<EmployeeInOutEntity>>> call(
// //       {NoParams? param}) async {
// //     final currentUser = UserService().currentUser;
// //     final employeeInOut = EmployeeInOutEntity(
// //       // inbyusername: currentUser?.username, //  when need filter by current user
// //       gateid: currentUser?.gateid,
// //       pageSize: 100,
// //       currentPage: 1,
// //       currentlocal: ????
// //       sortexpression: 'InTime DESC',
// //     );

// //     try {
// //       final result =
// //           await sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
// //       return result.fold(
// //         (failure) => Left(
// //             failure), // If repository returns Either<Failure, List<EmployeeInOutEntity>>
// //         (data) => Right(data),
// //       );
// //     } catch (e) {
// //       return Left(ServerFailure(e.toString()));
// //     }
// //   }
// // }

// // // import 'package:gipms/core/usecase/usecase.dart';
// // // import 'package:gipms/data/source/user_service.dart';
// // // import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
// // // import 'package:gipms/domain/entities/employee_in_out_entity.dart';
// // // import 'package:gipms/domain/repository/in_out_employee_repository.dart';
// // // import 'package:gipms/service_locator.dart';
// // // import 'package:dartz/dartz.dart';

// // // class ListInOutEmployeeUseCase
// // //     implements UseCase<Either, InOutEmployeeReqParams> {
// // //   @override
// // //   Future<Either> call({InOutEmployeeReqParams? param}) async {
// // //     final currentUser = UserService().currentUser;
// // //     EmployeeInOutEntity employeeInOut = EmployeeInOutEntity();
// // //     //employeeInOut.inbyusername = currentUser?.username;
// // //     employeeInOut.gateid = currentUser?.gateid;
// // //     employeeInOut.pageSize = 100;
// // //     employeeInOut.currentPage = 1;
// // //     employeeInOut.SortExpression = 'InTime DESC';
// // //     return sl<InOutEmployeeRepository>().listInOutEmployee(employeeInOut);
// // //   }
// // // }
