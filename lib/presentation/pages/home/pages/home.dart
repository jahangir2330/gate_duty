// ignore_for_file: unused_import
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
import 'package:gipms/common/bloc/button/button_state_cubit.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:gipms/domain/usecases/get_employee_usecase.dart';
import 'package:gipms/domain/usecases/logout.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/presentation/pages/auth/signup.dart';
import 'package:gipms/presentation/pages/common/app_drawer.dart';
import 'package:gipms/presentation/pages/gen/employee/scan_qrcode_page.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';
import 'package:gipms/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/bloc/button/button_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthStateCubit>().logout();
            },
          ),
        ],
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          //  ButtonStateCubit is now provided in main.dart
        ],
        child: Center(
          child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Image.asset(
                      'assets/images/logo-gif-Animate.gif',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 120),
                    ),
                    _username(context, state.userEntity),
                    const SizedBox(height: 10),
                    _rolename(context, state.userEntity),
                    const SizedBox(height: 10),
                    _gatename(context, state.userEntity),
                    _qrscan(context),
                    const SizedBox(height: 10),
                    // _logout(context),
                  ],
                );
              }
              if (state is LoadUserFailure) {
                return Text(state.errorMessage);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _username(BuildContext context, UserEntity user) {
    return Text(
      AppLocalizations.of(context)!.greeting(user.username),
      style: const TextStyle(
          color: Color(0xff3B4054), fontWeight: FontWeight.w500),
    );
  }

  Widget _gatename(BuildContext context, UserEntity user) {
    return Text(
      AppLocalizations.of(context)!.gateNameWithPlaceholder(user.gatenamear),
      style: const TextStyle(
          color: Color(0xff3B4054), fontWeight: FontWeight.w500),
    );
  }

  Widget _rolename(BuildContext context, UserEntity user) {
    return Text(
      AppLocalizations.of(context)!.gateNameWithPlaceholder(user.rolename),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _qrscan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: BasicAppButton(
        title: AppLocalizations.of(context)!.qrscan,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(RouteName.qrscan);
        },
      ),
    );
  }
}

// // ignore_for_file: unused_import
// import 'package:gipms/common/bloc/button/button_state_cubit.dart';
// import 'package:gipms/common/widgets/button/basic_app_button.dart';
// import 'package:gipms/core/routes/route_name.dart';
// import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
// import 'package:gipms/domain/entities/user_entity.dart';
// import 'package:gipms/domain/usecases/get_employee_usecase.dart';
// import 'package:gipms/domain/usecases/logout.dart';
// import 'package:gipms/main.dart';
// import 'package:gipms/presentation/pages/auth/signup.dart';
// import 'package:gipms/presentation/pages/common/app_drawer.dart';
// import 'package:gipms/presentation/pages/gen/employee/scan_qrcode_page.dart';
// import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart';
// import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';
// import 'package:gipms/service_locator.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../common/bloc/button/button_state.dart';
// import 'package:gipms/gen/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Locale? _currentLocale;

//   @override
//   void initState() {
//     super.initState();
//     _loadLocale();
//   }

//   Future<void> _loadLocale() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? savedLocale = prefs.getString('locale');
//     if (savedLocale != null) {
//       setState(() {
//         _currentLocale = Locale(
//             savedLocale.split('_')[0],
//             savedLocale.split('_').length > 1
//                 ? savedLocale.split('_')[1]
//                 : null);
//       });
//     } else {
//       _currentLocale = const Locale('ar'); // Default locale
//     }
//   }

//   Future<void> _changeLocale(Locale newLocale) async {
//     setState(() {
//       _currentLocale = newLocale;
//     });
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('locale', newLocale.toString());
//     // Force a rebuild of the MaterialApp to apply the new locale
//     final app = context.findAncestorStateOfType<MyAppWrapperState>();
//     app?.setLocale(newLocale);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context)!.helloWorld),
//         automaticallyImplyLeading: false,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//       ),
//       drawer: const AppDrawer(),
//       body: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
//           //  ButtonStateCubit is now provided in main.dart
//         ],
//         child: Center(
//           child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
//             builder: (context, state) {
//               if (state is UserLoading) {
//                 return const CircularProgressIndicator();
//               }
//               if (state is UserLoaded) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(AppLocalizations.of(context)!
//                             .english), // Assuming you have these keys
//                         Switch(
//                           value: _currentLocale == const Locale('en'),
//                           onChanged: (bool value) {
//                             _changeLocale(value
//                                 ? const Locale('en')
//                                 : const Locale('ar'));
//                           },
//                         ),
//                         Text(AppLocalizations.of(context)!.arabic),
//                       ],
//                     ),
//                     Image.asset(
//                       'assets/images/logo-gif-Animate.gif',
//                       height: 120,
//                       width: 120,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                           const Icon(Icons.error, size: 120),
//                     ),
//                     _username(state.userEntity),
//                     const SizedBox(height: 10),
//                     _rolename(state.userEntity),
//                     const SizedBox(height: 10),
//                     _gatename(state.userEntity),
//                     _qrscan(context),
//                     const SizedBox(height: 10),
//                     // _logout(context),
//                   ],
//                 );
//               }
//               if (state is LoadUserFailure) {
//                 return Text(state.errorMessage);
//               }
//               return Container();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _username(UserEntity user) {
//     return Text.rich(
//       TextSpan(children: [
//         const TextSpan(
//           text: "Welcome ",
//           style:
//               TextStyle(color: Color(0xff3B4054), fontWeight: FontWeight.w500),
//         ),
//         TextSpan(
//           text: user.username,
//           style: const TextStyle(
//               color: Color(0xff3461FD), fontWeight: FontWeight.w500),
//         )
//       ]),
//     );
//   }

//   Widget _gatename(UserEntity user) {
//     return Text(
//       user.gatenamear,
//       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//     );
//   }

//   Widget _rolename(UserEntity user) {
//     return Text(
//       user.rolename,
//       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//     );
//   }

//   Widget _qrscan(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(32),
//       child: BasicAppButton(
//         title: 'Scan QR Code',
//         onPressed: () {
//           Navigator.of(context).pushReplacementNamed(RouteName.qrscan);
//         },
//       ),
//     );
//   }
// }
