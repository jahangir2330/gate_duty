part of 'employee_list_cubit.dart';

abstract class EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoading extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final List<EmployeeInOutEntity> employees; // Adjust the entity type
  EmployeeListLoaded(this.employees);
}

class EmployeeListError extends EmployeeListState {
  final String message;
  EmployeeListError(this.message);
}
