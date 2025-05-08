import 'package:gipms/core/usecase/usecase.dart';
import 'package:gipms/domain/repository/auth.dart';
import 'package:gipms/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
