part of 'login_bloc_bloc.dart';

@immutable
class LoginBlocState {}

class LoginBlocInitial extends LoginBlocState {}

class LoginBlocLoading extends LoginBlocState {}

class LoginBlocSuccess extends LoginBlocState {}

class LoginBlocError extends LoginBlocState {
  final String error;

  LoginBlocError({required this.error});
}
