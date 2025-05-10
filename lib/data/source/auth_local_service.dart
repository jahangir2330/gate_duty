import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:gipms/data/source/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    if (token == null) {
      return false;
    }

    try {
      final jwt = JWT.decode(token);

      final expiry =
          jwt.payload['exp']; // 'exp' is the standard expiration claim

      if (expiry is int) {
        final expirationDateTime =
            DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
        final now = DateTime.now().toUtc(); // Compare with UTC time

        if (expirationDateTime.isBefore(now)) {
          return false;
        } else {
          return true;
        }
      } else {
        return true; // If no clear expiry, consider valid (or handle differently)
      }
      // ignore: unused_catch_clause
    } on JWTException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> isLoggedIn() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var token = sharedPreferences.getString('token');
  //   if (token == null) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  @override
  Future<Either> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    UserService().clearUser();
    return const Right(true);
  }
}
