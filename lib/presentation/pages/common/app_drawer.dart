import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
import 'package:gipms/core/routes/route_name.dart'; // Import route names
import 'package:gipms/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLocale = prefs.getString('locale');
    if (savedLocale != null) {
      setState(() {
        _currentLocale = Locale(
          savedLocale.split('_')[0],
          savedLocale.split('_').length > 1 ? savedLocale.split('_')[1] : null,
        );
      });
    } else {
      _currentLocale = const Locale('ar'); // Default locale
    }
  }

  Future<void> _changeLocale(bool isEnglish) async {
    final newLocale = isEnglish ? const Locale('en') : const Locale('ar');
    setState(() {
      _currentLocale = newLocale;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', newLocale.toString());
    final app = context.findAncestorStateOfType<MyAppWrapperState>();
    app?.setLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.english),
                const SizedBox(width: 8),
                Switch(
                  value: _currentLocale == const Locale('en'),
                  onChanged: _changeLocale,
                ),
                const SizedBox(width: 8),
                Text(AppLocalizations.of(context)!.arabic),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppLocalizations.of(context)!.home),
            onTap: () {
              Navigator.of(context).pop();
              // Use pushReplacementNamed only if you want to replace the current route
              Navigator.of(context).pushNamed(RouteName.home);
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.qr_code),
          //   title: Text(AppLocalizations.of(context)!.qrscan),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushNamed(RouteName.qrscan);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(AppLocalizations.of(context)!.employeelist),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(RouteName.employeelist);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.profile),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(RouteName.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () {
              Navigator.of(context).pop();
              // Use pushReplacementNamed for logout to prevent going back
              context.read<AuthStateCubit>().logout();
              Navigator.of(
                context,
              ).pushReplacementNamed(RouteName.login); //important
            },
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
// // Import service locator
// // Import ButtonStateCubit
// // Import LogoutUseCase
// import 'package:gipms/core/routes/route_name.dart'; // Import route names
// import 'package:gipms/l10n/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
// import '../../../main.dart'; // Import your main.dart where MyAppWrapper is

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({super.key});

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
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

//   Future<void> _changeLocale(bool isEnglish) async {
//     final newLocale = isEnglish ? const Locale('en') : const Locale('ar');
//     setState(() {
//       _currentLocale = newLocale;
//     });
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('locale', newLocale.toString());
//     // Force a rebuild of the MaterialApp
//     // ignore: use_build_context_synchronously
//     final app = context.findAncestorStateOfType<MyAppWrapperState>();
//     app?.setLocale(newLocale);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Menu',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             //child: Container(
//             //color: Colors.blue, // Set the background color here
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(AppLocalizations.of(context)!.english),
//                 const SizedBox(width: 8),
//                 Switch(
//                   value: _currentLocale == const Locale('en'),
//                   onChanged: _changeLocale,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(AppLocalizations.of(context)!.arabic),
//               ],
//             ),
//           ),
//           //),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: Text(AppLocalizations.of(context)!
//                 .home), // Assuming you have 'home' in your ARB files
//             onTap: () {
//               Navigator.of(context).pop(); // Close the drawer
//               Navigator.pushNamed(context, RouteName.home);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.qr_code),
//             title: Text(AppLocalizations.of(context)!
//                 .qrscan), // Assuming you have 'qrScan'
//             onTap: () {
//               Navigator.of(context).pop(); // Close the drawer
//               Navigator.of(context).pushReplacementNamed(RouteName.qrscan);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.list),
//             title: Text(AppLocalizations.of(context)!
//                 .employeelist), // Assuming you have 'qrScan'
//             onTap: () {
//               Navigator.of(context).pop(); // Close the drawer
//               Navigator.of(context).pushNamed(RouteName.employeelist);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.person),
//             title: Text(AppLocalizations.of(context)!
//                 .profile), // Assuming you have 'profile'
//             onTap: () {
//               Navigator.of(context).pop(); // Close the drawer
//               Navigator.of(context).pushReplacementNamed(RouteName.profile);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: Text(AppLocalizations.of(context)!
//                 .logout), // Assuming you have 'logout'
//             onTap: () {
//               Navigator.of(context).pop();
//               try {
//                 context.read<AuthStateCubit>().logout();
//                 Navigator.of(context).pushReplacementNamed(RouteName.login);
//               } catch (e) {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(SnackBar(content: Text("Logout Failed: $e")));
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
