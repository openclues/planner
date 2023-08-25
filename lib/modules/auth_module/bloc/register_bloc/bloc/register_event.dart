part of 'register_bloc.dart';

@immutable
class RegisterEvent {}

class EmailRegister extends RegisterEvent {
  final String email;
  final String password;

  EmailRegister({required this.email, required this.password});
}
