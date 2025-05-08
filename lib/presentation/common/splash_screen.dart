// import 'package:flutter/material.dart';
// import 'package:gipms/core/routes/route_name.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 5), () {
//       _checkAuthAndNavigate();
//     });
//   }

//   Future<void> _checkAuthAndNavigate() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final isAuthenticated = await authProvider
//         .checkAuthenticate(); // Assuming checkAuthenticate returns the current state

//     if (isAuthenticated) {
//       Navigator.pushReplacementNamed(context, RouteName.home);
//     } else {
//       Navigator.pushReplacementNamed(
//         context,
//         RouteName.login,
//       ); // Or your login route
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //backgroundColor: Colors.blue.shade200,
//       body: Center(
//         // child: CircularProgressIndicator(), // Show a loading indicator
//         child: Image.asset(
//           'assets/images/logo-gif-Animate.gif',
//           width: 150,
//           height: 150,
//         ),
//       ),
//     );
//   }
// }
