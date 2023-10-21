part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final SignUpResponse model;

  const SignUpSuccess({
    required this.model,
  });}
class SignUpFailure extends SignUpState {
  final StackTrace stackTrace;
  final Object exception;

  const SignUpFailure(this.exception, this.stackTrace);
}
