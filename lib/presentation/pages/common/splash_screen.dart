// ignore_for_file: use_build_context_synchronously

import 'package:gipms/common/bloc/auth/auth_state.dart';
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
import 'package:gipms/presentation/pages/auth/signin.dart';
import 'package:gipms/presentation/pages/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Add const constructor

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add the 5-second delay here.
    Future.delayed(const Duration(seconds: 5), () {
      //  The navigation logic is moved *inside* the delayed function.
      //  This ensures it happens *after* the delay.
      BlocProvider.of<AuthStateCubit>(context).stream.listen((state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SigninPage(),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade200, //  Branding color
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo-gif-Animate.gif',
                    height: 220,
                    width: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 120),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _appname(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appname() {
    return const Text(
      "GIPMS",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }
}
