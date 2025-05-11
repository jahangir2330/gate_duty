import 'package:gipms/common/bloc/button/button_state.dart';
import 'package:gipms/common/bloc/button/button_state_cubit.dart';
import 'package:gipms/common/bloc/employee_bloc/employee_state_cubit.dart';
import 'package:gipms/common/bloc/employee_bloc/view_employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
import 'package:gipms/domain/usecases/in_employee_usecase.dart';
import 'package:gipms/domain/usecases/out_employee_usecase.dart';
import 'package:gipms/common/widgets/button/success_app_button.dart';
import 'package:gipms/common/widgets/button/danger_app_button.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/service_locator.dart';

class ViewEmployeePage extends StatelessWidget {
  const ViewEmployeePage({super.key, this.parameterUrl, this.referralCode});

  final String? parameterUrl;
  final int? referralCode; // Receive referralCode

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ButtonStateCubit>(
      create: (context) => ButtonStateCubit(),
      child: BlocProvider(
        create: (context) {
          final cubit = ViewEmployeeCubit();
          if (parameterUrl != null && parameterUrl!.isNotEmpty) {
            cubit.fetchEmployee(parameterUrl!);
          } else if (referralCode != null) {
            cubit.fetchEmployeeByRequestEmployeeId(referralCode!);
          }
          return cubit;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.employeeview),
            leading: IconButton(
              // Add a leading icon button for back navigation
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteName.employeelist);
              },
            ),
          ),
          body: BlocConsumer<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                Navigator.pushReplacementNamed(context, RouteName.employeelist);
              } else if (state is ButtonFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<ViewEmployeeCubit, ViewEmployeeState>(
                builder: (context, viewEmployeeState) {
                  if (viewEmployeeState is ViewEmployeeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (viewEmployeeState is ViewEmployeeLoaded) {
                    final employee = viewEmployeeState.employee;

                    return Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //   'Employee Details',
                            //   style: TextStyle(
                            //       fontSize: 24, fontWeight: FontWeight.bold),
                            // ),
                            // const SizedBox(height: 10),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  employee.thumbspersonalpicure,
                                  height: 150,
                                  width: 119,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, size: 120),
                                ),
                              ),
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.fullName,
                              employee.fullName,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.referenceNumber,
                              employee.referencenumber,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.companyName,
                              employee.companyname,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.nationality,
                              employee.nationalityname,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.jobTitle,
                              employee.jobtitle,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.civilId,
                              employee.civilidnumber,
                            ),
                            _buildDateTimeText(
                              AppLocalizations.of(context)!.startDate,
                              employee.startdate,
                            ),
                            _buildDateTimeText(
                              AppLocalizations.of(context)!.endDate,
                              employee.enddate,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.gateName,
                              employee.gatenamesstring,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.vehicleNumberPlates,
                              employee.vehiclenumberplates,
                            ),
                            _buildStyledText(
                              AppLocalizations.of(context)!.lastEntryStatus,
                              employee.lastentrystatusid.toString(),
                            ),
                            const SizedBox(height: 20),
                            if (employee.lastentrystatusid == 2)
                              _outEmployeeButton(
                                  context, employee.requestemployeeid)
                            else
                              _inEmployeeButton(
                                  context, employee.requestemployeeid),
                          ],
                        ),
                      ),
                    );
                  } else if (viewEmployeeState is ViewEmployeeError) {
                    return Center(
                        child: Text('Error: ${viewEmployeeState.message}'));
                  } else {
                    return const Center(
                        child: Text('No employee data to display.'));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _inEmployeeButton(BuildContext context, int employeeId) {
    return Builder(builder: (context) {
      return SuccessAppButton(
          title: AppLocalizations.of(context)!.enter,
          onPressed: () {
            context.read<ButtonStateCubit>().excute(
                usecase: sl<InEmployeeUseCase>(),
                params: IdAsReqParams(idParam: employeeId));
          });
    });
  }

  Widget _outEmployeeButton(BuildContext context, int employeeId) {
    return Builder(builder: (context) {
      return DangerAppButton(
          title: AppLocalizations.of(context)!.out,
          onPressed: () {
            context.read<ButtonStateCubit>().excute(
                usecase: sl<OutEmployeeUseCase>(),
                params: IdAsReqParams(idParam: employeeId));
          });
    });
  }

  Widget _buildStyledText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            TextSpan(text: value ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeText(String label, dynamic value) {
    String displayText;
    if (value is DateTime?) {
      displayText = value != null
          ? "${value.day.toString().padLeft(2, '0')}-${value.month.toString().padLeft(2, '0')}-${value.year}"
          : "N/A";
    } else {
      displayText = value?.toString() ?? "N/A";
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            TextSpan(text: displayText),
          ],
        ),
      ),
    );
  }
}

// import 'package:gipms/common/bloc/button/button_state.dart';
// import 'package:gipms/common/bloc/button/button_state_cubit.dart';
// import 'package:gipms/common/bloc/employee_bloc/employee_state_cubit.dart';
// import 'package:gipms/common/bloc/employee_bloc/view_employee_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gipms/core/routes/route_name.dart';
// import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
// import 'package:gipms/domain/usecases/in_employee_usecase.dart';
// import 'package:gipms/domain/usecases/out_employee_usecase.dart';
// import 'package:gipms/common/widgets/button/success_app_button.dart';
// import 'package:gipms/common/widgets/button/danger_app_button.dart';
// import 'package:gipms/l10n/app_localizations.dart';
// import 'package:gipms/service_locator.dart';

// class ViewEmployeePage extends StatelessWidget {
//   const ViewEmployeePage({super.key, this.parameterUrl, this.referralCode});

//   final String? parameterUrl;
//   final int? referralCode; // Receive referralCode

//   @override
//   Widget build(BuildContext context) {
//     final arguments =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     final requestemployeeid = arguments?['referralCode'] as int?;

//     return BlocProvider<ButtonStateCubit>(
//       create: (context) => ButtonStateCubit(),
//       child: BlocProvider(
//         create: (context) {
//           final cubit = ViewEmployeeCubit();
//           if (parameterUrl != null && parameterUrl!.isNotEmpty) {
//             cubit.fetchEmployee(parameterUrl!);
//           } else if (referralCode != null) {
//             cubit.fetchEmployeeByRequestEmployeeId(requestemployeeid!);
//           }
//           return cubit;
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(AppLocalizations.of(context)!.employeeview),
//             leading: IconButton(
//               // Add a leading icon button for back navigation
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, RouteName.employeelist);
//               },
//             ),
//           ),
//           body: BlocConsumer<ButtonStateCubit, ButtonState>(
//             listener: (context, state) {
//               if (state is ButtonSuccessState) {
//                 Navigator.pushReplacementNamed(context, RouteName.employeelist);
//               } else if (state is ButtonFailureState) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error: ${state.errorMessage}')),
//                 );
//               }
//             },
//             builder: (context, state) {
//               return BlocBuilder<ViewEmployeeCubit, ViewEmployeeState>(
//                 builder: (context, viewEmployeeState) {
//                   if (viewEmployeeState is ViewEmployeeLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (viewEmployeeState is ViewEmployeeLoaded) {
//                     final employee = viewEmployeeState.employee;

//                     return Center(
//                       child: SingleChildScrollView(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Employee Details',
//                               style: TextStyle(
//                                   fontSize: 24, fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 10),
//                             Center(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   employee.thumbspersonalpicure,
//                                   height: 120,
//                                   width: 120,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Icon(Icons.error, size: 120),
//                                 ),
//                               ),
//                             ),
//                             _buildStyledText(
//                               "JobTitle",
//                               employee.referencenumber,
//                             ),
//                             _buildStyledText(
//                               "Full Name",
//                               employee.fullName,
//                             ),
//                             _buildStyledText(
//                               "Employee Id",
//                               employee.requestemployeeid.toString(),
//                             ),
//                             _buildStyledText(
//                               "Company Name",
//                               employee.companyname,
//                             ),
//                             _buildStyledText(
//                               "Nationality",
//                               employee.nationalityname,
//                             ),
//                             _buildStyledText(
//                               "Civil ID",
//                               employee.civilidnumber,
//                             ),
//                             _buildDateTimeText(
//                               "Start Date",
//                               employee.startdate,
//                             ),
//                             _buildDateTimeText(
//                               "End Date",
//                               employee.enddate,
//                             ),
//                             _buildStyledText(
//                               "Allowed Gates",
//                               employee.gatenamesstring,
//                             ),
//                             _buildStyledText(
//                               "vehiclenumberplates",
//                               employee.vehiclenumberplates,
//                             ),
//                             _buildStyledText(
//                               "Last Entry Status Id",
//                               employee.lastentrystatusid.toString(),
//                             ),
//                             const SizedBox(height: 20),
//                             if (employee.lastentrystatusid == 2)
//                               _outEmployeeButton(
//                                   context, employee.requestemployeeid)
//                             else
//                               _inEmployeeButton(
//                                   context, employee.requestemployeeid),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () => Navigator.pushReplacementNamed(
//                                   context, RouteName.qrscan),
//                               child: const Text("Back to Scan"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else if (viewEmployeeState is ViewEmployeeError) {
//                     return Center(
//                         child: Text('Error: ${viewEmployeeState.message}'));
//                   } else {
//                     return Center(
//                         child: Text(
//                             'No employee data to display with ID: $receivedReferralCode'));
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _inEmployeeButton(BuildContext context, int employeeId) {
//     return Builder(builder: (context) {
//       return SuccessAppButton(
//           title: 'In',
//           onPressed: () {
//             context.read<ButtonStateCubit>().excute(
//                 usecase: sl<InEmployeeUseCase>(),
//                 params: IdAsReqParams(idParam: employeeId));
//           });
//     });
//   }

//   Widget _outEmployeeButton(BuildContext context, int employeeId) {
//     return Builder(builder: (context) {
//       return DangerAppButton(
//           title: 'Out',
//           onPressed: () {
//             context.read<ButtonStateCubit>().excute(
//                 usecase: sl<OutEmployeeUseCase>(),
//                 params: IdAsReqParams(idParam: employeeId));
//           });
//     });
//   }

//   Widget _buildStyledText(String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: RichText(
//         text: TextSpan(
//           style: const TextStyle(fontSize: 16, color: Colors.black),
//           children: [
//             TextSpan(
//               text: "$label: ",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             TextSpan(text: value ?? "N/A"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDateTimeText(String label, dynamic value) {
//     String displayText;
//     if (value is DateTime?) {
//       displayText =
//           value != null ? "${value.day}-${value.month}-${value.year}" : "N/A";
//     } else {
//       displayText = value?.toString() ?? "N/A";
//     }
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: RichText(
//         text: TextSpan(
//           style: const TextStyle(fontSize: 16, color: Colors.black),
//           children: [
//             TextSpan(
//               text: "$label: ",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             TextSpan(text: displayText),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:gipms/common/bloc/button/button_state.dart';
// // import 'package:gipms/common/bloc/button/button_state_cubit.dart';
// // import 'package:gipms/common/bloc/employee_bloc/employee_state_cubit.dart';
// // import 'package:gipms/common/bloc/employee_bloc/view_employee_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:gipms/core/routes/route_name.dart';
// // import 'package:gipms/data/viewmodels/in_out_employee_req_params.dart';
// // import 'package:gipms/domain/usecases/in_employee_usecase.dart';
// // import 'package:gipms/domain/usecases/out_employee_usecase.dart';
// // import 'package:gipms/common/widgets/button/success_app_button.dart';
// // import 'package:gipms/common/widgets/button/danger_app_button.dart';
// // import 'package:gipms/l10n/app_localizations.dart';
// // import 'package:gipms/service_locator.dart';

// // class ViewEmployeePage extends StatelessWidget {
// //   const ViewEmployeePage(
// //       {super.key, required this.parameterUrl, this.referralCode});

// //   final String? parameterUrl;
// //   final int? referralCode;

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider<ButtonStateCubit>(
// //       create: (context) => ButtonStateCubit(),
// //       child: BlocProvider(
// //         create: (context) => ViewEmployeeCubit()..fetchEmployee(parameterUrl!),
// //         child: Scaffold(
// //           appBar: AppBar(
// //             title: Text(AppLocalizations.of(context)!.employeeview),
// //             leading: IconButton(
// //               // Add a leading icon button for back navigation
// //               icon: const Icon(Icons.arrow_back),
// //               onPressed: () {
// //                 Navigator.pushReplacementNamed(context, RouteName.employeelist);
// //               },
// //             ),
// //           ),
// //           body: BlocConsumer<ButtonStateCubit, ButtonState>(
// //             listener: (context, state) {
// //               if (state is ButtonSuccessState) {
// //                 Navigator.pushReplacementNamed(context, RouteName.employeelist);
// //               } else if (state is ButtonFailureState) {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Error: ${state.errorMessage}')),
// //                 );
// //               }
// //             },
// //             builder: (context, state) {
// //               return BlocBuilder<ViewEmployeeCubit, ViewEmployeeState>(
// //                 builder: (context, viewEmployeeState) {
// //                   if (viewEmployeeState is ViewEmployeeLoading) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   } else if (viewEmployeeState is ViewEmployeeLoaded) {
// //                     final employee = viewEmployeeState.employee;

// //                     return Center(
// //                       child: SingleChildScrollView(
// //                         padding: const EdgeInsets.all(16.0),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text(
// //                               'Employee Details',
// //                               style: TextStyle(
// //                                   fontSize: 24, fontWeight: FontWeight.bold),
// //                             ),
// //                             const SizedBox(height: 10),
// //                             Center(
// //                               child: ClipRRect(
// //                                 borderRadius: BorderRadius.circular(8),
// //                                 child: Image.network(
// //                                   employee.thumbspersonalpicure,
// //                                   height: 120,
// //                                   width: 120,
// //                                   fit: BoxFit.cover,
// //                                   errorBuilder: (context, error, stackTrace) =>
// //                                       const Icon(Icons.error, size: 120),
// //                                 ),
// //                               ),
// //                             ),
// //                             _buildStyledText(
// //                               "JobTitle",
// //                               employee.referencenumber,
// //                             ),
// //                             _buildStyledText(
// //                               "Full Name",
// //                               employee.fullName,
// //                             ),
// //                             _buildStyledText(
// //                               "Employee Id",
// //                               employee.requestemployeeid.toString(),
// //                             ),
// //                             _buildStyledText(
// //                               "Company Name",
// //                               employee.companyname,
// //                             ),
// //                             _buildStyledText(
// //                               "Nationality",
// //                               employee.nationalityname,
// //                             ),
// //                             _buildStyledText(
// //                               "Civil ID",
// //                               employee.civilidnumber,
// //                             ),
// //                             _buildDateTimeText(
// //                               "Start Date",
// //                               employee.startdate,
// //                             ),
// //                             _buildDateTimeText(
// //                               "End Date",
// //                               employee.enddate,
// //                             ),
// //                             _buildStyledText(
// //                               "Allowed Gates",
// //                               employee.gatenamesstring,
// //                             ),
// //                             _buildStyledText(
// //                               "vehiclenumberplates",
// //                               employee.vehiclenumberplates,
// //                             ),
// //                             _buildStyledText(
// //                               "Last Entry Status Id",
// //                               employee.lastentrystatusid.toString(),
// //                             ),
// //                             const SizedBox(height: 20),
// //                             if (employee.lastentrystatusid == 2)
// //                               _outEmployeeButton(
// //                                   context, employee.requestemployeeid)
// //                             else
// //                               _inEmployeeButton(
// //                                   context, employee.requestemployeeid),
// //                             const SizedBox(height: 20),
// //                             ElevatedButton(
// //                               onPressed: () => Navigator.pushReplacementNamed(
// //                                   context, RouteName.qrscan),
// //                               child: const Text("Back to Scan"),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   } else if (viewEmployeeState is ViewEmployeeError) {
// //                     return Center(
// //                         child: Text('Error: ${viewEmployeeState.message}'));
// //                   } else {
// //                     return const Center(
// //                         child: Text('No employee data to display.'));
// //                   }
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _inEmployeeButton(BuildContext context, int employeeId) {
// //     return Builder(builder: (context) {
// //       return SuccessAppButton(
// //           title: 'In',
// //           onPressed: () {
// //             context.read<ButtonStateCubit>().excute(
// //                 usecase: sl<InEmployeeUseCase>(),
// //                 params: IdAsReqParams(idParam: employeeId));
// //           });
// //     });
// //   }

// //   Widget _outEmployeeButton(BuildContext context, int employeeId) {
// //     return Builder(builder: (context) {
// //       return DangerAppButton(
// //           title: 'Out',
// //           onPressed: () {
// //             context.read<ButtonStateCubit>().excute(
// //                 usecase: sl<OutEmployeeUseCase>(),
// //                 params: IdAsReqParams(idParam: employeeId));
// //           });
// //     });
// //   }

// //   Widget _buildStyledText(String label, String? value) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8.0),
// //       child: RichText(
// //         text: TextSpan(
// //           style: const TextStyle(fontSize: 16, color: Colors.black),
// //           children: [
// //             TextSpan(
// //               text: "$label: ",
// //               style: const TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.blue,
// //               ),
// //             ),
// //             TextSpan(text: value ?? "N/A"),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDateTimeText(String label, dynamic value) {
// //     String displayText;
// //     if (value is DateTime?) {
// //       displayText =
// //           value != null ? "${value.day}-${value.month}-${value.year}" : "N/A";
// //     } else {
// //       displayText = value?.toString() ?? "N/A";
// //     }
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8.0),
// //       child: RichText(
// //         text: TextSpan(
// //           style: const TextStyle(fontSize: 16, color: Colors.black),
// //           children: [
// //             TextSpan(
// //               text: "$label: ",
// //               style: const TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.blue,
// //               ),
// //             ),
// //             TextSpan(text: displayText),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
