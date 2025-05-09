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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
  ));
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          create: (context) => UserDisplayCubit()
            ..displayUser(), //  Fetch user data here or in initState() of a parent widget
        ),
      ],
      child: MaterialApp(
        //title: Text(AppLocalizations.of(context)!.helloWorld),
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
        locale: const Locale("ar"),
      ),
    );
  }
}
