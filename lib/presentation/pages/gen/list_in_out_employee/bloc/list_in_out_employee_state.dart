part of 'list_in_out_employee_cubit.dart';

abstract class ListInOutEmployeeState {}

class ListInOutEmployeeInitial extends ListInOutEmployeeState {}

class ListInOutEmployeeLoading extends ListInOutEmployeeState {}

class ListInOutEmployeeLoaded extends ListInOutEmployeeState {
  final List<EmployeeInOutEntity> employees; // Adjust the entity type
  ListInOutEmployeeLoaded(this.employees);
}

class ListInOutEmployeeError extends ListInOutEmployeeState {
  final String? message; // Make message nullable for flexibility
  ListInOutEmployeeError(this.message);
}

// part of 'list_in_out_employee_cubit.dart';

// abstract class ListInOutEmployeeState {}

// class ListInOutEmployeeInitial extends ListInOutEmployeeState {}

// class ListInOutEmployeeLoading extends ListInOutEmployeeState {}

// class ListInOutEmployeeLoaded extends ListInOutEmployeeState {
//   final List<EmployeeInOutEntity> employees; // Adjust the entity type
//   ListInOutEmployeeLoaded(this.employees);
// }

// class ListInOutEmployeeError extends ListInOutEmployeeState {
//   final String message;
//   ListInOutEmployeeError(this.message);
// }
