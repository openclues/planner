import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:planner/config/auth_token_handler.dart';
import 'package:planner/modules/auth_module/data/login_repo.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginBlocInitial()) {
    LoginRepo loginRepo = LoginRepo();
    on<LoginBlocEvent>((event, emit) {});
    on<EmailLoginEvent>((event, emit) async {
      emit(LoginBlocLoading());
      var response = await loginRepo.emaillogin(event.email, event.password);
      if (response.statusCode == 400 || response.statusCode == 401) {
        emit(LoginBlocError(error: response.body));
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        var tokenJson = jsonDecode(response.body);
        String token = tokenJson['auth_token'];
        AuthTokenSaveAndGet.saveAuthToken(token);
        emit(LoginBlocSuccess());
      }
    });
  }
}
