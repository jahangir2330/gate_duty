import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/service_locator.dart'; // Import service locator
import 'package:gipms/common/bloc/button/button_state_cubit.dart'; // Import ButtonStateCubit
import 'package:gipms/domain/usecases/logout.dart'; // Import LogoutUseCase
import 'package:gipms/core/routes/route_name.dart'; // Import route names

//  AppDrawer Widget (in lib/widgets/app_drawer.dart)
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Handle Home action
              Navigator.of(context).pop(); // Close the drawer
              Navigator.pushNamed(context, RouteName.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('QR Scan'),
            onTap: () {
              // Handle Settings action
              Navigator.of(context).pop(); // Close the drawer
              Navigator.of(context).pushReplacementNamed(RouteName.qrscan);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Handle logout
              Navigator.of(context).pop();
              try {
                context
                    .read<ButtonStateCubit>()
                    .excute(usecase: sl<LogoutUseCase>());
                Navigator.pushNamed(context, RouteName.login);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(// show error to user
                    SnackBar(content: Text("Logout Failed: $e")));
              }
            },
          ),
        ],
      ),
    );
  }
}
