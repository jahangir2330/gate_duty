// homepage.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/bloc/auth/auth_state_cubit.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/common/widgets/will_pop_confirmation.dart'; // Import the reusable widget
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/presentation/pages/common/app_drawer.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_cubit.dart';
import 'package:gipms/presentation/pages/home/bloc/user_display_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopConfirmation(
      // confirmationTitle:
      //     AppLocalizations.of(context)!.confirmExit, // Using localization
      // confirmationMessage:
      //     AppLocalizations.of(context)!.exitConfirmation, // Using localization
      child: Scaffold(
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
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
        ),
        drawer: const AppDrawer(),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserDisplayCubit()..displayUser(),
            ),
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
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error, size: 120),
                      ),
                      _username(context, state.userEntity),
                      const SizedBox(height: 10),
                      _rolename(context, state.userEntity),
                      const SizedBox(height: 10),
                      _gatename(context, state.userEntity),
                      //_qrscan(context),
                      const SizedBox(height: 10),
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

  Widget _username(BuildContext context, UserEntity user) {
    return Text(
      AppLocalizations.of(context)!.greeting(user.username),
      style: const TextStyle(
        color: Color(0xff3B4054),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _rolename(BuildContext context, UserEntity user) {
    return Text(
      AppLocalizations.of(context)!.rolenameWithPlaceholder(user.rolename),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _gatename(BuildContext context, UserEntity user) {
    return Text(
      AppLocalizations.of(context)!.gateNameWithPlaceholder(user.gatenamear),
      style: const TextStyle(
        color: Color(0xff3B4054),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _qrscan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: BasicAppButton(
        title: AppLocalizations.of(context)!.qrscan,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(RouteName.employeelist);
        },
      ),
    );
  }
}
