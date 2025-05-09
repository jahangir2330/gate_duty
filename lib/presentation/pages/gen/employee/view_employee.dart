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
import 'package:gipms/service_locator.dart';

// Assuming you have a Hom
class ViewEmployeePage extends StatelessWidget {
  const ViewEmployeePage(
      {super.key, required this.parameterUrl, this.referralCode});

  final String? parameterUrl;
  final String? referralCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ButtonStateCubit>(
      create: (context) => ButtonStateCubit(),
      child: BlocProvider(
        create: (context) => ViewEmployeeCubit()..fetchEmployee(parameterUrl!),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('View Employee'),
          ),
          body: BlocConsumer<ButtonStateCubit, ButtonState>(
            // Use BlocConsumer to listen for state changes
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                // Navigate to the home screen after a successful button action
                Navigator.pushReplacementNamed(context, RouteName.home);
                // Alternatively, you could use:
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                // );
              } else if (state is ButtonFailureState) {
                // Optionally handle the error (e.g., show a snackbar)
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
                            const Text(
                              'Employee Details',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  employee.thumbspersonalpicure,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error, size: 120),
                                ),
                              ),
                            ),
                            _buildStyledText(
                              "Job Title",
                              employee.referencenumber,
                            ),
                            _buildStyledText(
                              "Full Name",
                              employee.fullName,
                            ),
                            _buildStyledText(
                              "Employee Id",
                              employee.requestemployeeid.toString(),
                            ),
                            _buildStyledText(
                              "Company Name",
                              employee.companyname,
                            ),
                            _buildStyledText(
                              "Nationality",
                              employee.nationalityname,
                            ),
                            _buildStyledText(
                              "Civil ID",
                              employee.civilidnumber,
                            ),
                            _buildDateTimeText(
                              "Start Date",
                              employee.startdate,
                            ),
                            _buildDateTimeText(
                              "End Date",
                              employee.enddate,
                            ),
                            _buildStyledText(
                              "Allowed Gates",
                              employee.gatenamesstring,
                            ),
                            _buildStyledText(
                              "vehiclenumberplates",
                              employee.vehiclenumberplates,
                            ),
                            _buildStyledText(
                              "Last Entry Status Id",
                              employee.lastentrystatusid.toString(),
                            ),
                            const SizedBox(height: 20),
                            if (employee.lastentrystatusid == 2)
                              _outEmployeeButton(context,
                                  employee.requestemployeeid.toString())
                            else
                              _inEmployeeButton(context,
                                  employee.requestemployeeid.toString()),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                  context, RouteName.qrscan),
                              child: const Text("Back to Scan"),
                            ),
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

  Widget _inEmployeeButton(BuildContext context, String employeeId) {
    return Builder(builder: (context) {
      return BasicAppButton(
          title: 'In',
          onPressed: () {
            context.read<ButtonStateCubit>().excute(
                usecase: sl<InEmployeeUseCase>(),
                params: InOutEmployeeReqParams(requestemployeeid: employeeId));
          });
    });
  }

  Widget _outEmployeeButton(BuildContext context, String employeeId) {
    return Builder(builder: (context) {
      return BasicAppButton(
          title: 'Out',
          onPressed: () {
            context.read<ButtonStateCubit>().excute(
                usecase: sl<OutEmployeeUseCase>(),
                params: InOutEmployeeReqParams(requestemployeeid: employeeId));
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
      displayText =
          value != null ? "${value.day}-${value.month}-${value.year}" : "N/A";
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
// class ViewEmployeePage extends StatelessWidget {
//   const ViewEmployeePage(
//       {super.key, required this.parameterUrl, this.referralCode});

//   final String? parameterUrl;
//   final String? referralCode;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ButtonStateCubit>(
//       create: (context) => ButtonStateCubit(),
//       child: BlocProvider(
//         create: (context) => ViewEmployeeCubit()..fetchEmployee(parameterUrl!),
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('View Employee'),
//           ),
//           body: BlocBuilder<ViewEmployeeCubit, ViewEmployeeState>(
//             builder: (context, state) {
//               if (state is ViewEmployeeLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is ViewEmployeeLoaded) {
//                 final employee = state.employee;

//                 return Center(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Employee Details',
//                           style: TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               employee.thumbspersonalpicure,
//                               height: 120,
//                               width: 120,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) =>
//                                   const Icon(Icons.error, size: 120),
//                             ),
//                           ),
//                         ),
//                         _buildStyledText(
//                           "Job Title",
//                           employee.referencenumber,
//                         ),
//                         _buildStyledText(
//                           "Full Name",
//                           employee.fullName,
//                         ),
//                         _buildStyledText(
//                           "Employee Id",
//                           employee.requestemployeeid.toString(),
//                         ),
//                         _buildStyledText(
//                           "Company Name",
//                           employee.companyname,
//                         ),
//                         _buildStyledText(
//                           "Nationality",
//                           employee.nationalityname,
//                         ),
//                         _buildStyledText(
//                           "Civil ID",
//                           employee.civilidnumber,
//                         ),
//                         _buildDateTimeText(
//                           "Start Date",
//                           employee.startdate,
//                         ),
//                         _buildDateTimeText(
//                           "End Date",
//                           employee.enddate,
//                         ),
//                         _buildStyledText(
//                           "Allowed Gates",
//                           employee.gatenamesstring,
//                         ),
//                         _buildStyledText(
//                           "vehiclenumberplates",
//                           employee.vehiclenumberplates,
//                         ),
//                         _buildStyledText(
//                           "Last Entry Status Id",
//                           employee.lastentrystatusid.toString(),
//                         ),
//                         const SizedBox(height: 20),
//                         if (employee.lastentrystatusid == 2)
//                           _outEmployeeButton(context)
//                         else
//                           _inEmployeeButton(context),
//                         const SizedBox(height: 20),
//                         const SizedBox(height: 10),
//                         ElevatedButton(
//                           onPressed: () => Navigator.pushReplacementNamed(
//                               context, RouteName.qrscan),
//                           child: const Text("Back to Scan"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else if (state is ViewEmployeeError) {
//                 return Center(child: Text('Error: ${state.message}'));
//               } else {
//                 return const Center(
//                     child: Text('No employee data to display.'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _inEmployeeButton(BuildContext context) {
//     return Builder(builder: (context) {
//       final state = context.watch<ViewEmployeeCubit>().state;
//       if (state is ViewEmployeeLoaded) {
//         final employee = state.employee;
//         return BasicAppButton(
//             title: 'In',
//             onPressed: () {
//               context.read<ButtonStateCubit>().excute(
//                   usecase: sl<InEmployeeUseCase>(),
//                   params: InOutEmployeeReqParams(
//                       requestemployeeid:
//                           employee.requestemployeeid.toString()));
//             });
//       }
//       return const SizedBox.shrink(); // Or some other fallback widget
//     });
//   }

//   Widget _outEmployeeButton(BuildContext context) {
//     return Builder(builder: (context) {
//       final state = context.watch<ViewEmployeeCubit>().state;
//       if (state is ViewEmployeeLoaded) {
//         final employee = state.employee;
//         return BasicAppButton(
//             title: 'Out',
//             onPressed: () {
//               context.read<ButtonStateCubit>().excute(
//                   usecase: sl<OutEmployeeUseCase>(),
//                   params: InOutEmployeeReqParams(
//                       requestemployeeid:
//                           employee.requestemployeeid.toString()));
//             });
//       }
//       return const SizedBox.shrink(); // Or some other fallback widget
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
