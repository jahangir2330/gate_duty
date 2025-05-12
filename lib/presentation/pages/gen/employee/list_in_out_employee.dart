import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipms/common/widgets/button/basic_app_button.dart';
import 'package:gipms/core/routes/route_name.dart';
import 'package:gipms/l10n/app_localizations.dart';
import 'package:gipms/presentation/pages/common/app_drawer.dart';
import 'package:gipms/presentation/pages/gen/employee/bloc/list_in_out_employee_cubit.dart';
import 'package:gipms/service_locator.dart'; // Adjust import

class ListInOutEmployeePage extends StatelessWidget {
  const ListInOutEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ListInOutEmployeeCubit>()
        ..fetchEmployees(), // Fetch data when the page is created
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.employeelist),
        ),
        drawer: const AppDrawer(),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: BlocBuilder<ListInOutEmployeeCubit, ListInOutEmployeeState>(
              builder: (context, state) {
                if (state is ListInOutEmployeeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListInOutEmployeeLoaded) {
                  final employees = state.employees;
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      _scanAgainButton(context),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemCount: employees.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(height: 1),
                          itemBuilder: (BuildContext context, int index) {
                            final employee = employees[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                // Apply LinearGradient to the Card's background
                                color: Colors
                                    .transparent, // Make default color transparent
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                      RouteName.employeeview,
                                      arguments: {
                                        'referralCode':
                                            employee.requestemployeeid,
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      // This BoxDecoration will paint the gradient
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue[100]!,
                                          Colors.blue[50]!,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          employee.entrystatusid == 2
                                              ? Icons.arrow_downward_rounded
                                              : Icons.arrow_upward_rounded,
                                          size: 40,
                                          color: employee.entrystatusid == 2
                                              ? Colors.green[700]
                                              : Colors.red[700],
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildStyledText(
                                                AppLocalizations.of(context)!
                                                    .fullName,
                                                employee.fullname,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(height: 4),
                                              _buildStyledText(
                                                AppLocalizations.of(context)!
                                                    .civilId,
                                                employee.civilidnumber,
                                                color: Colors.black87,
                                              ),
                                              const SizedBox(height: 4),
                                              _buildStyledText(
                                                AppLocalizations.of(context)!
                                                    .companyName,
                                                employee.companyname,
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                              const SizedBox(height: 4),
                                              _buildDateTimeText(
                                                AppLocalizations.of(context)!
                                                    .startDate,
                                                employee.intime,
                                                color: Colors.grey[700],
                                                fontSize: 14,
                                              ),
                                              const SizedBox(height: 4),
                                              _buildStyledText(
                                                AppLocalizations.of(context)!
                                                    .entrystatusname,
                                                employee.entrystatusname,
                                                color: Colors.blueAccent,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.chevron_right,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is ListInOutEmployeeError) {
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

  Widget _buildDateTimeText(String label, dynamic value,
      {FontWeight? fontWeight, Color? color, double? fontSize}) {
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
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          style:
              TextStyle(fontSize: fontSize ?? 14, color: color ?? Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            TextSpan(
                text: displayText, style: TextStyle(fontWeight: fontWeight)),
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

Widget _buildStyledText(String label, String? value,
    {FontWeight? fontWeight, Color? color, double? fontSize}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: RichText(
      text: TextSpan(
        style:
            TextStyle(fontSize: fontSize ?? 14, color: color ?? Colors.black),
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          TextSpan(
              text: value ?? "N/A", style: TextStyle(fontWeight: fontWeight)),
        ],
      ),
    ),
  );
}
