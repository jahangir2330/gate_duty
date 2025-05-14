import 'package:equatable/equatable.dart';

abstract class ButtonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ButtonInitialState extends ButtonState {}

class ButtonLoadingState extends ButtonState {}

class ButtonSuccessState<T> extends ButtonState {
  final T data;

  ButtonSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ButtonFailureState extends ButtonState {
  final String errorMessage;

  ButtonFailureState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
// abstract class ButtonState {}

// class ButtonInitialState extends ButtonState {}

// class ButtonLoadingState extends ButtonState {}

// class ButtonSuccessState extends ButtonState {}

// class ButtonFailureState extends ButtonState {
//   final String errorMessage;
//   ButtonFailureState({required this.errorMessage});
// }
