part of 'user_bloc.dart';

@immutable
class UserEvent {}

class UpdateUserInformationEvent extends UserEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  UpdateUserInformationEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
  });
}

class UpdateUserImageEvent extends UserEvent {
  final XFile? image;

  UpdateUserImageEvent({required this.image});
}
