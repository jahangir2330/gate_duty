import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/presentation/pages/common/app_drawer.dart';
import 'package:gipms/presentation/pages/gen/employee/bloc/employee_list_cubit.dart';
import 'package:gipms/service_locator.dart'; // Adjust import

class ListEmployeePage extends StatelessWidget {
  const ListEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EmployeeListCubit>()
        ..fetchEmployees(), // Fetch data when the page is created
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.employeelist),
        ),

        // const SizedBox(height: 20),
        // _scanAgainButton(context),
        // const SizedBox(height: 20),
        drawer: const AppDrawer(),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
              builder: (context, state) {
                if (state is EmployeeListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmployeeListLoaded) {
                  final employees = state.employees;
                  //hree
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      _scanAgainButton(context),
                      const SizedBox(height: 20),
                      Expanded(
                          child: ListView.separated(
                        itemCount: employees.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                                height: 1), // Add a divider between rows
                        itemBuilder: (BuildContext context, int index) {
                          final employee = employees[index];
                          final isEven = index % 2 == 0;
                          final rowColor =
                              isEven ? Colors.grey[100] : Colors.white;

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                RouteName.employeeview,
                                arguments: {
                                  // Pass arguments as a map
                                  'referralCode': employee.requestemployeeid,
                                },
                              );
                            },
                            child: Container(
                              color: rowColor,
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  if (employee.entrystatusid == 2)
                                    const Icon(Icons.arrow_circle_down,
                                        size: 50, color: Colors.green)
                                  else
                                    const Icon(Icons.arrow_circle_up,
                                        size: 50, color: Colors.red),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        _buildStyledText(
                                          AppLocalizations.of(context)!
                                              .fullName,
                                          employee.fullname,
                                        ),
                                        _buildStyledText(
                                          AppLocalizations.of(context)!.civilId,
                                          employee.civilidnumber,
                                        ),
                                        _buildStyledText(
                                          AppLocalizations.of(context)!
                                              .companyName,
                                          employee.companyname,
                                        ),
                                        _buildStyledText(
                                          AppLocalizations.of(context)!
                                              .gateName,
                                          employee.gatename,
                                        ),
                                        _buildDateTimeText(
                                          AppLocalizations.of(context)!
                                              .startDate,
                                          employee.intime,
                                        ),
                                        _buildStyledText(
                                          AppLocalizations.of(context)!
                                              .entrystatusname,
                                          employee.entrystatusname,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ))
                    ],
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

  Widget _buildDateTimeText(String label, dynamic value) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
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

Widget _scanAgainButton(BuildContext context) {
  return Builder(builder: (context) {
    return BasicAppButton(
        title: AppLocalizations.of(context)!.rescan,
        onPressed: () {
          Navigator.pushReplacementNamed(context, RouteName.qrscan);
        });
  });
}

Widget _buildStyledText(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 0),
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
