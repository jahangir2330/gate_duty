// ignore_for_file: unused_import

import 'package:gipms/common/bloc/button/button_state_cubit.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/data/viewmodels/getemployee_req_params.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:gipms/domain/usecases/get_employee_usecase.dart';
import 'package:gipms/domain/usecases/logout.dart';
import 'package:gipms/presentation/auth/pages/signup.dart';
import 'package:gipms/presentation/gen/pages/get_employee.dart';
import 'package:gipms/presentation/home/bloc/user_display_cubit.dart';
import 'package:gipms/presentation/home/bloc/user_display_state.dart';
import 'package:gipms/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/button/button_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ));
            }
          },
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
                      _username(state.userEntity),
                      const SizedBox(
                        height: 10,
                      ),
                      _email(state.userEntity),
                      // _logout(context),
                      _qrscan(context)
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
      ),
    );
  }

  Widget _username(UserEntity user) {
    return Text(
      user.username,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _email(UserEntity user) {
    return Text(
      user.email,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  // Widget _logout(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(32),
  //     child: BasicAppButton(
  //         title: 'Logout',
  //         onPressed: () {
  //           context
  //               .read<ButtonStateCubit>()
  //               .excute(usecase: sl<LogoutUseCase>());
  //         }),
  //   );
  // }

  // Widget _qrscan(BuildContext context) {
  //   return Builder(builder: (context) {
  //     return BasicAppButton(
  //         title: 'Scan QR',
  //         onPressed: () {
  //           context.read<ButtonStateCubit>().excute(
  //               usecase: sl<GetEmployeeUseCase>(),
  //               params: GetEmployeeReqParams(qrcode: "ww"));
  //         });
  //   });
  // }

  Widget _qrscan(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: "This is Home Page ",
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Go to scan page',
            style: const TextStyle(
                color: Color(0xff3461FD), fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GetEmployeePage(),
                    ));
              })
      ]),
    );
  }
}
