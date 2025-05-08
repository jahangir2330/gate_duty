import 'package:auth/common/bloc/employee_bloc/employee_state_cubit.dart';
import 'package:auth/common/bloc/employee_bloc/view_employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewEmployeePage extends StatelessWidget {
  ViewEmployeePage({super.key, required this.parameterUrl, this.referralCode});

  final String? parameterUrl;
  final String? referralCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewEmployeeCubit()
        ..fetchEmployee(parameterUrl!), // Create and trigger fetch
      child: Scaffold(
        appBar: AppBar(
          title: const Text('View Employee'),
        ),
        body: BlocBuilder<ViewEmployeeCubit, ViewEmployeeState>(
          builder: (context, state) {
            if (state is ViewEmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ViewEmployeeLoaded) {
              final employee =
                  state.employee; // This is now your EmployeeEntity object

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
                        employee.startdate, // Pass the DateTime? object
                      ),
                      _buildDateTimeText(
                        "End Date",
                        employee.enddate, // Pass the DateTime? object
                      ),
                      _buildStyledText(
                        "Allowed Gates",
                        employee.gatenamesstring,
                      ),
                      _buildStyledText(
                        "vehiclenumberplates",
                        employee.vehiclenumberplates,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            } else if (state is ViewEmployeeError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No employee data to display.'));
            }
          },
          // builder: (context, state) {
          //   if (state is ViewEmployeeLoading) {
          //     return const Center(child: CircularProgressIndicator());
          //   } else if (state is ViewEmployeeLoaded) {
          //     final employee = state.employee;
          //     return Center(
          //       child: SingleChildScrollView(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Text(
          //               'Employee Details',
          //               style: TextStyle(
          //                   fontSize: 24, fontWeight: FontWeight.bold),
          //             ),
          //             const SizedBox(height: 20),
          //             Text('Full Name: ${employee.fullName}'),
          //             if (employee.fullNameen != null)
          //               Text('Full Name (EN): ${employee.fullNameen}'),
          //             Text('Civil ID: ${employee.civilidnumber}'),
          //             Text('Job Title: ${employee.jobtitle}'),
          //             Text(
          //                 'Nationality: ${employee.nationalityname} (${employee.nationalitynamear})'),
          //             Text(
          //                 'Company: ${employee.companyname} (${employee.companynamear})'),
          //             Text(
          //                 'License Type: ${employee.licensetypename} (${employee.licensetypenamear})'),
          //             // Text('Request Type: ${employee.requesttypename}'),
          //             Text(
          //                 'Status: ${employee.statusname} (${employee.statusnamear})'),
          //             Text('Reference Number: ${employee.referencenumber}'),
          //             Text(
          //                 'Emergency Contact: ${employee.emergencycontactnumber}'),
          //             Text(
          //                 'Start Date: ${employee.startdate?.toLocal().toString() ?? "N/A"}'),
          //             Text(
          //                 'End Date: ${employee.enddate?.toLocal().toString() ?? "N/A"}'),
          //             Text('Number of Vehicles: ${employee.numberofvehicle}'),
          //             Text('Vehicle Plate(s): ${employee.vehiclenumberplates}'),
          //             // Display other relevant fields from the EmployeeEntity
          //           ],
          //         ),
          //       ),
          //     );
          //   } else if (state is ViewEmployeeError) {
          //     return Center(child: Text('Error: ${state.message}'));
          //   } else {
          //     return const Center(child: Text('No employee data to display.'));
          //   }
          // },
        ),
      ),
    );
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
