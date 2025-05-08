import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart'; // Import your AuthStateCubit
import 'package:gipms/core/configs/theme/app_theme.dart';
import 'package:gipms/presentation/pages/common/splash_screen.dart';
import 'package:flutter/services.dart';
import 'service_locator.dart'; // Import service locator

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  ));
  setupServiceLocator(); // Initialize service locator
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return BlocProvider(
      create: (context) =>
          AuthStateCubit()..appStarted(), //  Initialize and check auth state
      child: MaterialApp(
        title: 'GIPMS',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(), // Set SplashScreen as the home
      ),
    );
  }
}
//2222222222222222222222222
// import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
// import 'package:gipms/presentation/auth/pages/signin.dart';
// import 'package:gipms/presentation/home/pages/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'common/bloc/auth/auth_state.dart';
// import 'core/configs/theme/app_theme.dart';
// import 'service_locator.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarBrightness: Brightness.light,
//       systemNavigationBarColor: Colors.black));
//   setupServiceLocator();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.bottom]);
//     return BlocProvider(
//       create: (context) => AuthStateCubit()..appStarted(),
//       child: MaterialApp(
//           title: 'GIPMS',
//           theme: AppTheme.lightTheme,
//           darkTheme: AppTheme.darkTheme,
//           themeMode: ThemeMode.system,
//           debugShowCheckedModeBanner: false,
//           home: BlocBuilder<AuthStateCubit, AuthState>(
//             builder: (context, state) {
//               if (state is Authenticated) {
//                 return const HomePage();
//               }
//               if (state is UnAuthenticated) {
//                 return SigninPage();
//               }
//               return Container();
//             },
//           )),
//     );
//   }
// }
