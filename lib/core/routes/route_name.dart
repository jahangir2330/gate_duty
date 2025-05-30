import 'package:flutter/material.dart';
import 'package:gipms/presentation/pages/auth/signin.dart';
import 'package:gipms/presentation/pages/auth/signup.dart';
import 'package:gipms/presentation/pages/common/profile_page.dart';
import 'package:gipms/presentation/pages/common/splash_screen.dart';
import 'package:gipms/presentation/pages/gen/list_in_out_employee/pages/list_in_out_employee.dart';
import 'package:gipms/presentation/pages/gen/view_employee/scan_qrcode_page.dart';
import 'package:gipms/presentation/pages/gen/view_employee/view_employee.dart';
import 'package:gipms/presentation/pages/home/pages/home.dart';
// Import other view files as necessary

class RouteName {
  // You can keep your existing RouteName class
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String qrscan = '/qrscan';
  static const String profile = '/profile';
  static const String employeeview = '/employee_detail';
  static const String employeelist = '/employee_list';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.home:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case RouteName.signup:
      return MaterialPageRoute(builder: (_) => SignupPage());
    case RouteName.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case RouteName.login:
      return MaterialPageRoute(builder: (_) => const SigninPage());
    case RouteName.profile:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case RouteName.qrscan:
      return MaterialPageRoute(builder: (_) => const ScanQrCodePage());
    case RouteName.employeelist:
      return MaterialPageRoute(builder: (_) => const ListInOutEmployeePage());
    case RouteName.employeeview:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => ViewEmployeePage(
          parameterUrl:
              args?['parameterUrl'] ?? '', // Provide a default value if needed
          referralCode: args?['referralCode'],
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Unknown Route'))));
  }
}
