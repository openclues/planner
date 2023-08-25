part of 'auth_bloc.dart';

@immutable
class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authsuccess extends AuthState {}
class AuthError extends AuthState {}
