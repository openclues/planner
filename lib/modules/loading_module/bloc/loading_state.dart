part of 'loading_bloc.dart';

@immutable
class LoadingState {}

class LoadingInitial extends LoadingState {}

class LoadingCheckingState extends LoadingState {}

class LoadingUserLoggedInState extends LoadingState {
  final String usersData;
  final User user;

  LoadingUserLoggedInState({
    required this.usersData,
    required this.user,
  });
}

class LoadingUserIsNotLoggedInLoadingState extends LoadingState {}

class LoadingUserInvalidToken extends LoadingState {}

class LoadingUserIncompleteProfile extends LoadingState {
  final User user;

  LoadingUserIncompleteProfile({required this.user});
}
