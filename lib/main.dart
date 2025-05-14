import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/presentation/pages/common/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart';
import 'package:gipms/service_locator.dart';
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
import 'package:gipms/common/bloc/button/button_state_cubit.dart';
import 'package:gipms/core/configs/theme/app_theme.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/core/routes/route_name.dart' as route_generator;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Add this import:
import 'package:provider/provider.dart'; // Import the provider package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  ));
  setupServiceLocator();
  runApp(const MyAppWrapper());
}

class MyAppWrapper extends StatefulWidget {
  const MyAppWrapper({super.key});

  @override
  MyAppWrapperState createState() => MyAppWrapperState();
}

class MyAppWrapperState extends State<MyAppWrapper> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLocale = prefs.getString('locale');
    //  print('Loaded locale: $savedLocale'); // Debugging: Check the loaded locale
    if (savedLocale != null) {
      setState(() {
        _currentLocale = Locale(
          savedLocale.split('_')[0],
          savedLocale.split('_').length > 1 ? savedLocale.split('_')[1] : null,
        );
      });
    } else {
      setState(() {
        _currentLocale = const Locale('ar'); // Default to Arabic
      });
      // print('Default locale set to: $_currentLocale'); // Debugging
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    // print('Setting locale to: $newLocale'); // Debugging
    setState(() {
      _currentLocale = newLocale;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLocale.toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MultiProvider(
      // Use MultiProvider from the provider package
      providers: [
        BlocProvider<AuthStateCubit>(
          create: (context) => AuthStateCubit()..appStarted(),
        ),
        BlocProvider<ButtonStateCubit>(
          create: (context) => ButtonStateCubit(),
        ),
        BlocProvider<UserDisplayCubit>(
          create: (context) => UserDisplayCubit()..displayUser(),
        ),
      ],
      child: MaterialApp(
        locale: _currentLocale,
        title: 'GIPMS',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.splash,
        onGenerateRoute: route_generator.generateRoute,
        home: const SplashScreen(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'), // Arabic
          Locale('en'), // English
        ],
      ),
    );
  }
}

// Example Widget to Toggle Locale (You can place this anywhere in your UI)
class LocaleSwitcher extends StatelessWidget {
  const LocaleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<MyAppWrapperState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            appState?.setLocale(const Locale('en'));
          },
          child: const Text('English'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            appState?.setLocale(const Locale('ar'));
          },
          child: const Text('Arabic'),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gipms/presentation/pages/common/splash_screen.dart';
// import 'package:flutter/services.dart';
// import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
// import 'package:gipms/common/bloc/button/button_state_cubit.dart';
// import 'package:gipms/core/configs/theme/app_theme.dart';
// import 'package:gipms/core/routes/route_name.dart';
// import 'package:gipms/core/routes/route_name.dart' as route_generator;
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:gipms/gen/app_localizations.dart';
// // ignore: depend_on_referenced_packages
// import 'package:provider/provider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarBrightness: Brightness.light,
//     systemNavigationBarColor: Colors.black,
//   ));
//   setupServiceLocator();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.bottom]);
//     return MultiProvider(
//       // Use MultiProvider from the provider package
//       providers: [
//         BlocProvider<AuthStateCubit>(
//           create: (context) => AuthStateCubit()..appStarted(),
//         ),
//         BlocProvider<ButtonStateCubit>(
//           create: (context) => ButtonStateCubit(),
//         ),
//         BlocProvider<UserDisplayCubit>(
//           create: (context) => UserDisplayCubit()
//             ..displayUser(), //  Fetch user data here or in initState() of a parent widget
//         ),
//       ],
//       child: MaterialApp(
//         //title: Text(AppLocalizations.of(context)!.helloWorld),
//         title: 'GIPMS',
//         theme: AppTheme.lightTheme,
//         darkTheme: AppTheme.darkTheme,
//         themeMode: ThemeMode.system,
//         debugShowCheckedModeBanner: false,
//         initialRoute: RouteName.splash,
//         onGenerateRoute: route_generator.generateRoute,
//         home: const SplashScreen(),
//         localizationsDelegates: const [
//           AppLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: const [
//           Locale('ar'), // Arabic
//           Locale('en'), // English
//         ],
//         locale: const Locale("ar"),
//       ),
//     );
//   }
// }
