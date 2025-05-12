import 'package:gipms/core/network/dio_client.dart';
import 'package:gipms/data/repository/auth.dart';
import 'package:gipms/data/repository/employee_repository.dart';
import 'package:gipms/data/repository/in_out_employee_repository.dart';
import 'package:gipms/data/source/auth_api_service.dart';
import 'package:gipms/data/source/auth_local_service.dart';
import 'package:gipms/data/source/employee_api_service.dart';
import 'package:gipms/data/source/in_out_employee_api_service.dart';
import 'package:gipms/domain/repository/auth.dart';
import 'package:gipms/domain/repository/employee_repository.dart';
import 'package:gipms/domain/repository/in_out_employee_repository.dart';
import 'package:gipms/domain/usecases/get_employee_by_id_usecase.dart';
import 'package:gipms/domain/usecases/get_employee_by_qrcode_usecase.dart';
import 'package:gipms/domain/usecases/get_user.dart';
import 'package:gipms/domain/usecases/in_employee_usecase.dart';
import 'package:gipms/domain/usecases/is_logged_in.dart';
import 'package:gipms/domain/usecases/list_in_out_employee_usecase.dart';
import 'package:gipms/domain/usecases/logout.dart';
import 'package:gipms/domain/usecases/out_employee_usecase.dart';
import 'package:gipms/domain/usecases/signin.dart';
import 'package:gipms/domain/usecases/signup.dart';
import 'package:get_it/get_it.dart';
import 'package:gipms/presentation/pages/gen/list_in_out_employee/bloc/list_in_out_employee_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //Cubit
  sl.registerFactory(() => ListInOutEmployeeCubit(sl()));
  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<EmployeeApiService>(EmployeeApiServiceImpl());
  sl.registerSingleton<InOutEmployeeApiService>(InOutEmployeeApiServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<EmployeeRepository>(EmployeeRepositoryImpl());
  sl.registerSingleton<InOutEmployeeRepository>(InOutEmployeeRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetEmployeeByQrCodeUseCase>(
      GetEmployeeByQrCodeUseCase());
  sl.registerSingleton<GetEmployeeByRequestEmployeeIdUseCase>(
      GetEmployeeByRequestEmployeeIdUseCase());

  sl.registerSingleton<InEmployeeUseCase>(InEmployeeUseCase());
  sl.registerSingleton<OutEmployeeUseCase>(OutEmployeeUseCase());
  sl.registerSingleton<ListInOutEmployeeUseCase>(ListInOutEmployeeUseCase());
}
