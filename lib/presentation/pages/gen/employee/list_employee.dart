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
                  return ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (BuildContext context, int index) {
                      final employee = employees[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            RouteName.employeeview,
                            arguments:
                                employee, // Pass employee data if needed for the view page
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person,
                                  size:
                                      50), // Replace with an actual image if available
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee.fullname ??
                                          'N/A', // Display employee name
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      employee.civilidnumber ??
                                          'N/A', // Display other relevant info
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    // Add more Text widgets to display other employee details
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
                  return const Center(child: Text('No data')); // Initial state
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:gipms/core/routes/route_name.dart';
// import 'package:gipms/l10n/app_localizations.dart';

// class ListEmployeePage extends StatelessWidget {
//   const ListEmployeePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppLocalizations.of(context)!.employeelist),
//       ),
//       body: Center(
//         child: Container(
//           constraints: const BoxConstraints(maxWidth: 500),
//           child: ListView.builder(
//             itemCount: _images.length,
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushReplacementNamed(RouteName.employeeview);
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Hero(
//                         tag: index,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             _images[index],
//                             width: 200,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                           child: Text(
//                         'Title: $index',
//                         style: Theme.of(context).textTheme.titleMedium,
//                       )),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// final List<String> _images = [
//   'https://images.pexels.com/photos/167699/pexels-photo-167699.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
//   'https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
//   'https://images.pexels.com/photos/273935/pexels-photo-273935.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
//   'https://images.pexels.com/photos/1591373/pexels-photo-1591373.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
//   'https://images.pexels.com/photos/462024/pexels-photo-462024.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
//   'https://images.pexels.com/photos/325185/pexels-photo-325185.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
// ];
