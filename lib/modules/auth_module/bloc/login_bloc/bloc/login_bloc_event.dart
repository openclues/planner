part of 'login_bloc_bloc.dart';

@immutable
class LoginBlocEvent {}

class EmailLoginEvent extends LoginBlocEvent {
  final String email;
  final String password;

  EmailLoginEvent({required this.email, required this.password});
}
