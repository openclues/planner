part of 'user_bloc.dart';

@immutable
class UserState {}

class UserInitial extends UserState {}

class UpdateUserInformationLoading extends UserState {}

class UpdateUserInformationLoaded extends UserState {}

class UpdateUserInformationError extends UserState {}

class UpdateUserImageError extends UserState {
  final String error;

  UpdateUserImageError({required this.error});
}

class UpdateUserImageLoading extends UserState {}

class UpdateUserImageLoaded extends UserState {}
