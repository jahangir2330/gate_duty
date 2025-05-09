// ignore_for_file: unused_import
import 'package:gipms/common/bloc/button/button_state_cubit.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:gipms/domain/usecases/get_employee_usecase.dart';
import 'package:gipms/domain/usecases/logout.dart';
import 'package:gipms/presentation/pages/auth/signup.dart';
import 'package:gipms/presentation/pages/common/app_drawer.dart';
import 'package:gipms/presentation/pages/gen/employee/scan_qrcode_page.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';
import 'package:gipms/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/bloc/button/button_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                    Image.asset(
                      'assets/images/logo-gif-Animate.gif',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 120),
                    ),
                    _username(state.userEntity),
                    const SizedBox(height: 10),
                    _rolename(state.userEntity),
                    const SizedBox(height: 10),
                    _gatename(state.userEntity),
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

  Widget _username(UserEntity user) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
          text: "Welcome ",
          style:
              TextStyle(color: Color(0xff3B4054), fontWeight: FontWeight.w500),
        ),
        TextSpan(
          text: user.username,
          style: const TextStyle(
              color: Color(0xff3461FD), fontWeight: FontWeight.w500),
        )
      ]),
    );
  }

  Widget _gatename(UserEntity user) {
    return Text(
      user.gatenamear,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _rolename(UserEntity user) {
    return Text(
      user.rolename,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _qrscan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: BasicAppButton(
        title: 'Scan QR Code',
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(RouteName.qrscan);
        },
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: BasicAppButton(
        title: 'Logout',
        onPressed: () {
          context.read<ButtonStateCubit>().excute(usecase: sl<LogoutUseCase>());
        },
      ),
    );
  }
}
