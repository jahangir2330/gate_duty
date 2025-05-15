import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/bloc/auth/auth_state.dart'; // Import the authentication state
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
import 'package:gipms/core/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        final authStateCubit = context.read<AuthStateCubit>();
        authStateCubit.stream.listen((state) {
          if (mounted) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacementNamed(RouteName.home);
            } else if (state is UnAuthenticated) {
              Navigator.of(context).pushReplacementNamed(RouteName.login);
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo-gif-Animate.gif',
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.error, size: 120),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _appName(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appName() {
    return const Text(
      "GIPMS",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }
}
