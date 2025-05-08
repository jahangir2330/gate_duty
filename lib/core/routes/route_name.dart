// class Routename {
//   static const String home = '/home';
//   static const String login = '/login';
//   static const String signup = '/signup';
//   static const String qrscan = '/qrscan';
//   static const String employeedetail = '/employeedetail';
//   // Add more as needed
// }

import 'package:flutter/material.dart';
import 'package:gipms/presentation/auth/pages/signin.dart';
import 'package:gipms/presentation/common/scan_qrcode_view.dart';
import 'package:gipms/presentation/gen/pages/view_employee.dart';
import 'package:gipms/presentation/home/pages/home.dart';
// Import other view files as necessary

class RouteName {
  // You can keep your existing RouteName class
  static const String home = '/home';
  static const String login = '/login';
  static const String qrscan = '/qrscan';
  static const String employeedetail = '/employee_detail';
}

final Map<String, WidgetBuilder> appRoutes = {
  RouteName.home: (context) => const HomePage(),
  RouteName.login: (context) => SigninPage(),
  RouteName.qrscan: (context) => const ScanQrCodeView(),
  //RouteName.employeedetail: (context) => ViewEmployeePage(),
};
