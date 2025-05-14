// import 'package:gipms/common/bloc/button/button_state.dart';
// import 'package:gipms/common/bloc/button/button_state_cubit.dart';
// import 'package:gipms/presentation/pages/gen/view_employee/bloc/employee_state_cubit.dart';
// import 'package:gipms/presentation/pages/gen/view_employee/bloc/view_employee_state.dart';
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
//     return BlocProvider<ButtonStateCubit>(
//       create: (context) => ButtonStateCubit(),
//       child: BlocProvider(
//         create: (context) {
//           final cubit = ViewEmployeeCubit();
//           if (parameterUrl != null && parameterUrl!.isNotEmpty) {
//             cubit.fetchEmployee(parameterUrl!);
//           } else if (referralCode != null) {
//             cubit.fetchEmployeeByRequestEmployeeId(referralCode!);
//           }
//           return cubit;
//         },
//         child: Scaffold(
//           backgroundColor: Colors.grey[100], // Subtle background color
//           appBar: AppBar(
//             title: Text(AppLocalizations.of(context)!.employeeview),
//             leading: IconButton(
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

//                     return SingleChildScrollView(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Profile Header
//                           Center(
//                             child: Column(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 60,
//                                   backgroundImage: NetworkImage(
//                                       employee.thumbspersonalpicure),
//                                   // onBackgroundImageError:
//                                   //     (exception, stackTrace) {
//                                   //   return const Icon(Icons.person, size: 80);
//                                   // },
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   employee.fullName,
//                                   style: const TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 //const SizedBox(height: 5),
//                                 // Text(
//                                 //   employee.jobtitle ??
//                                 //       AppLocalizations.of(context)!
//                                 //           .notAvailable,
//                                 //   style: TextStyle(color: Colors.grey[600]),
//                                 // ),
//                                 const SizedBox(height: 20),
//                               ],
//                             ),
//                           ),

//                           // Personal Details Card
//                           Card(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Text(
//                                   //   AppLocalizations.of(context)!
//                                   //       .personalDetails,
//                                   //   style: const TextStyle(
//                                   //     fontSize: 18,
//                                   //     fontWeight: FontWeight.bold,
//                                   //   ),
//                                   // ),
//                                   // const Divider(
//                                   //     thickness: 1, color: Colors.grey),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!
//                                         .referenceNumber,
//                                     employee.referencenumber,
//                                   ),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.nationality,
//                                     employee.nationalityname,
//                                   ),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.civilId,
//                                     employee.civilidnumber,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Company Details Card
//                           Card(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Text(
//                                   //   AppLocalizations.of(context)!.jobDetails,
//                                   //   style: const TextStyle(
//                                   //     fontSize: 18,
//                                   //     fontWeight: FontWeight.bold,
//                                   //   ),
//                                   // ),
//                                   // const Divider(
//                                   //     thickness: 1, color: Colors.grey),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.companyName,
//                                     employee.companyname,
//                                   ),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.jobTitle,
//                                     employee.jobtitle,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           // Entry/Exit Details Card
//                           Card(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Text(
//                                   //   AppLocalizations.of(context)!
//                                   //       .premissionDetails,
//                                   //   style: const TextStyle(
//                                   //     fontSize: 18,
//                                   //     fontWeight: FontWeight.bold,
//                                   //   ),
//                                   // ),
//                                   // const Divider(
//                                   //     thickness: 1, color: Colors.grey),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.startDate,
//                                     employee.startdate != null
//                                         ? "${employee.startdate!.day.toString().padLeft(2, '0')}-${employee.startdate!.month.toString().padLeft(2, '0')}-${employee.startdate!.year}"
//                                         : AppLocalizations.of(context)!
//                                             .notAvailable,
//                                   ),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.endDate,
//                                     employee.enddate != null
//                                         ? "${employee.enddate!.day.toString().padLeft(2, '0')}-${employee.enddate!.month.toString().padLeft(2, '0')}-${employee.enddate!.year}"
//                                         : AppLocalizations.of(context)!
//                                             .notAvailable,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),

//                           // Entry/Exit Details Card
//                           Card(
//                             margin: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Text(
//                                   //   AppLocalizations.of(context)!.entryDetails,
//                                   //   style: const TextStyle(
//                                   //     fontSize: 18,
//                                   //     fontWeight: FontWeight.bold,
//                                   //   ),
//                                   // ),
//                                   // const Divider(
//                                   //     thickness: 1, color: Colors.grey),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!.gateName,
//                                     employee.gatenamesstring,
//                                   ),
//                                   _buildProfileDetail(
//                                     context,
//                                     AppLocalizations.of(context)!
//                                         .lastEntryStatus,
//                                     employee.lastentrystatusid.toString(),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 20),
//                           // Action Buttons
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               if (employee.lastentrystatusid == 2)
//                                 Expanded(
//                                     child: _outEmployeeButton(
//                                         context, employee.requestemployeeid))
//                               else
//                                 Expanded(
//                                     child: _inEmployeeButton(
//                                         context, employee.requestemployeeid)),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     );
//                   } else if (viewEmployeeState is ViewEmployeeError) {
//                     return Center(
//                         child: Text('Error: ${viewEmployeeState.message}'));
//                   } else {
//                     return const Center(
//                         child: Text('No employee data to display.'));
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
//       // <--- Inner 'context' is correctly scoped here
//       return SuccessAppButton(
//           title: AppLocalizations.of(context)!.enter,
//           onPressed: () {
//             // The 'context' you need is the one from the Builder's builder method
//             context.read<ButtonStateCubit>().excute(
//                 usecase: sl<InEmployeeUseCase>(),
//                 params: IdAsReqParams(idParam: employeeId));
//           });
//     });
//   }

//   Widget _outEmployeeButton(BuildContext context, int employeeId) {
//     return Builder(builder: (context) {
//       // <--- Inner 'context' is correctly scoped here
//       return DangerAppButton(
//           title: AppLocalizations.of(context)!.out,
//           onPressed: () {
//             // The 'context' you need is the one from the Builder's builder method
//             context.read<ButtonStateCubit>().excute(
//                 usecase: sl<OutEmployeeUseCase>(),
//                 params: IdAsReqParams(idParam: employeeId));
//           });
//     });
//   }

//   Widget _buildProfileDetail(
//       BuildContext context, String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "$label:",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//               color: Colors.blue,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value ?? AppLocalizations.of(context)!.notAvailable,
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildDateTimeText(BuildContext context, String label, dynamic value) {
//   //   String displayText;
//   //   if (value is DateTime?) {
//   //     displayText = value != null
//   //         ? "${value.day.toString().padLeft(2, '0')}-${value.month.toString().padLeft(2, '0')}-${value.year}"
//   //         : AppLocalizations.of(context)!.notAvailable;
//   //   } else {
//   //     displayText =
//   //         value?.toString() ?? AppLocalizations.of(context)!.notAvailable;
//   //   }
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         Text(
//   //           "$label:",
//   //           style: const TextStyle(
//   //             fontWeight: FontWeight.bold,
//   //             fontSize: 16,
//   //             color: Colors.blue,
//   //           ),
//   //         ),
//   //         Expanded(
//   //           child: Text(
//   //             displayText,
//   //             style: const TextStyle(fontSize: 16),
//   //             textAlign: TextAlign.right,
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

// }
