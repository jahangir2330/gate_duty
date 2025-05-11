import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gipms/common/bloc/button/button_state_cubit.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/data/viewmodels/signin_req_params.dart';
import 'package:gipms/domain/usecases/signin.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/service_locator.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../main.dart'; // Import your main.dart

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  Locale? _currentLocale;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

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
            savedLocale.split('_').length > 1
                ? savedLocale.split('_')[1]
                : null);
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
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: BlocListener<ButtonStateCubit, ButtonState>(
        // <--- BlocListener only
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.of(context).pushReplacementNamed(RouteName.home);
          }
          if (state is ButtonFailureState) {
            var snackBar = SnackBar(content: Text(state.errorMessage));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: isSmallScreen
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 150),
                    _Logo(),
                    const SizedBox(height: 30),
                    _FormContent(
                      usernameController: _usernameCon,
                      passwordController: _passwordCon,
                      formKey: _formKey,
                      isPasswordVisible: _isPasswordVisible,
                      togglePasswordVisibility: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      onSignInPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ButtonStateCubit>().excute(
                              // <--- Read the Cubit
                              usecase: sl<SigninUseCase>(),
                              params: SigninReqParams(
                                  username: _usernameCon.text,
                                  password: _passwordCon.text));
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    _LanguageSwitch(
                      currentLocale: _currentLocale,
                      onLocaleChanged: _changeLocale,
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    children: [
                      Expanded(child: _Logo()),
                      Expanded(
                        child: Center(
                          child: _FormContent(
                            usernameController: _usernameCon,
                            passwordController: _passwordCon,
                            formKey: _formKey,
                            isPasswordVisible: _isPasswordVisible,
                            togglePasswordVisibility: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            onSignInPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<ButtonStateCubit>().excute(
                                    // <--- Read the Cubit
                                    usecase: sl<SigninUseCase>(),
                                    params: SigninReqParams(
                                        username: _usernameCon.text,
                                        password: _passwordCon.text));
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: _LanguageSwitch(
                            currentLocale: _currentLocale,
                            onLocaleChanged: _changeLocale,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// ... The _Logo and _LanguageSwitch widgets remain the same ...

class _FormContent extends StatelessWidget {
  const _FormContent({
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    required this.onSignInPressed,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;
  final VoidCallback onSignInPressed;

  Widget _gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.username,
                hintText: AppLocalizations.of(context)!.username,
                prefixIcon: const Icon(Icons.person_outline),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!
                      .username; //usernameRequired
                }
                return null;
              },
            ),
            _gap(),
            TextFormField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!
                      .password; //passwordRequired
                }
                return null;
              },
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: BasicAppButton(
                title: AppLocalizations.of(context)!.signin,
                onPressed: onSignInPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSwitch extends StatelessWidget {
  const _LanguageSwitch({
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  final Locale? currentLocale;
  final Function(bool) onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.english),
        Switch(
          value: currentLocale == const Locale('en'),
          onChanged: (bool value) {
            onLocaleChanged(value);
          },
        ),
        Text(AppLocalizations.of(context)!.arabic),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo-gif-Animate.gif',
          height: isSmallScreen ? 100 : 120,
          width: isSmallScreen ? 100 : 120,
          fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return Icon(Icons.error, size: isSmallScreen ? 100 : 120);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context)!.signin,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff2A4ECA),
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 24 : 32,
            ),
          ),
        ),
      ],
    );
  }
}

// // //This code when log out try to go homepage
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:gipms/common/bloc/button/button_state_cubit.dart';
// import 'package:gipms/common/widgets/button/basic_app_button.dart';
// import 'package:gipms/core/routes/route_name.dart';
// import 'package:gipms/data/viewmodels/signin_req_params.dart';
// import 'package:gipms/domain/usecases/signin.dart';
// import 'package:gipms/l10n/app_localizations.dart';
// import 'package:gipms/service_locator.dart';

// import '../../../common/bloc/button/button_state.dart';
// import '../../../main.dart'; // Import your main.dart

// class SigninPage extends StatefulWidget {
//   const SigninPage({super.key});

//   @override
//   State<SigninPage> createState() => _SigninPageState();
// }

// class _SigninPageState extends State<SigninPage> {
//   final TextEditingController _usernameCon = TextEditingController();
//   final TextEditingController _passwordCon = TextEditingController();
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
//     // ignore: use_build_context_synchronously
//     final app = context.findAncestorStateOfType<MyAppWrapperState>();
//     app?.setLocale(newLocale);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => ButtonStateCubit(),
//         child: BlocListener<ButtonStateCubit, ButtonState>(
//           listener: (context, state) {
//             if (state is ButtonSuccessState) {
//               Navigator.of(context).pushReplacementNamed(RouteName.home);
//             }
//             if (state is ButtonFailureState) {
//               var snackBar = SnackBar(content: Text(state.errorMessage));
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             }
//           },
//           child: SafeArea(
//             minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     height: 100,
//                   ),
//                   Image.asset(
//                     'assets/images/logo-gif-Animate.gif',
//                     height: 120,
//                     width: 120,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) =>
//                         const Icon(Icons.error, size: 120),
//                   ),
//                   _signin(),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   _usernameField(),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   _password(),
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   _createAccountButton(context),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(AppLocalizations.of(context)!.english),
//                       Switch(
//                         value: _currentLocale == const Locale('en'),
//                         onChanged: (bool value) {
//                           _changeLocale(
//                               value); // Directly pass the boolean value
//                         },
//                       ),
//                       Text(AppLocalizations.of(context)!.arabic),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   //_signupText(context)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signin() {
//     return Text(
//       AppLocalizations.of(context)!.signin,
//       style: const TextStyle(
//           color: Color(0xff2A4ECA), fontWeight: FontWeight.bold, fontSize: 32),
//     );
//   }

//   Widget _usernameField() {
//     return TextField(
//       controller: _usernameCon,
//       decoration:
//           InputDecoration(hintText: AppLocalizations.of(context)!.username),
//     );
//   }

//   Widget _password() {
//     return TextField(
//       controller: _passwordCon,
//       decoration:
//           InputDecoration(hintText: AppLocalizations.of(context)!.password),
//     );
//   }

//   Widget _createAccountButton(BuildContext context) {
//     return Builder(builder: (context) {
//       return BasicAppButton(
//           title: AppLocalizations.of(context)!.signin,
//           onPressed: () {
//             context.read<ButtonStateCubit>().excute(
//                 usecase: sl<SigninUseCase>(),
//                 params: SigninReqParams(
//                     username: _usernameCon.text, password: _passwordCon.text));
//           });
//     });
//   }
// }
