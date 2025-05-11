import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/presentation/pages/gen/employee/bloc/employee_list_cubit.dart';
import 'package:gipms/service_locator.dart'; // Adjust import

class ListEmployeePage extends StatelessWidget {
  const ListEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EmployeeListCubit>()
        ..fetchEmployees(), // Fetch data when the page is created
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.employeelist),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
              builder: (context, state) {
                if (state is EmployeeListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmployeeListLoaded) {
                  final employees = state.employees;
                  return ListView.separated(
                    itemCount: employees.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(height: 1), // Add a divider between rows
                    itemBuilder: (BuildContext context, int index) {
                      final employee = employees[index];
                      final isEven =
                          index % 2 == 0; // Check if the index is even
                      final rowColor = isEven
                          ? Colors.grey[100] // Light background for even rows
                          : Colors.white; // White background for odd rows

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            RouteName.employeeview,
                            arguments: employee,
                          );
                        },
                        child: Container(
                          color: rowColor, // Apply the striped background color
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person, size: 50),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee.fullname ?? 'N/A',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      employee.civilidnumber ??
                                          'N/A', // Display employee name
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      employee.companyname ??
                                          'N/A', // Display other relevant info
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      employee.gatename ?? 'N/A',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      _buildDateTimeText(
                                          "Intime", employee.intime),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    // Add more Text widgets for other employee details
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is EmployeeListError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  String _buildDateTimeText(String label, dynamic value) {
    String displayText;
    if (value is DateTime?) {
      if (value != null) {
        final day = value.day.toString().padLeft(2, '0');
        final month = value.month.toString().padLeft(2, '0');
        final year = value.year.toString();
        final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
        final minute = value.minute.toString().padLeft(2, '0');
        final period = value.hour < 12 ? 'AM' : 'PM';
        displayText = "$day-$month-$year $hour:$minute $period";
      } else {
        displayText = "N/A";
      }
    } else {
      displayText = value?.toString() ?? "N/A";
    }
    return "$label: $displayText";
  }
}
