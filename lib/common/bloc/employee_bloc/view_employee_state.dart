import 'package:auth/domain/entities/employee_entity.dart';

abstract class ViewEmployeeState {}

class ViewEmployeeInitial extends ViewEmployeeState {}

class ViewEmployeeLoading extends ViewEmployeeState {}

class ViewEmployeeLoaded extends ViewEmployeeState {
  final EmployeeEntity employee;
  ViewEmployeeLoaded({required this.employee});
}

class ViewEmployeeError extends ViewEmployeeState {
  final String message;
  ViewEmployeeError({required this.message});
}
