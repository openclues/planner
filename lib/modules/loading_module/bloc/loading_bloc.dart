import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:planner/config/auth_token_handler.dart';
import 'package:planner/modules/loading_module/data/loading_repo.dart';
import 'package:planner/modules/user_module/data/user_model.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingRepo loadingRepo = LoadingRepo();
  LoadingBloc() : super(LoadingInitial()) {
    on<LoadingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadUserDataEvent>((event, emit) async {
      await Future.delayed(Duration(seconds: 2));
      if (await AuthTokenSaveAndGet.getAuthToken() == null) {
        emit(LoadingUserIsNotLoggedInLoadingState());
      } else {
        var response = await loadingRepo.checkUserLogin();
        if (response.statusCode == 200) {
          User user = User.fromMap(jsonDecode(response.body));
          if (user.firstName!.isEmpty || user.lastName!.isEmpty) {
            emit(LoadingUserIncompleteProfile(user: user));
          } else {
            emit(LoadingUserLoggedInState(
              usersData: response.body,
              user: user,
            ));
          }
        } else {
          emit(LoadingUserInvalidToken());
        }
      }
    });
  }
}
