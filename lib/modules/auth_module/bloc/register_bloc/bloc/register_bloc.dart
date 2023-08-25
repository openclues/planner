import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:planner/modules/auth_module/data/register_repo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    RegisterRepository registerRepository = RegisterRepository();
    on<RegisterEvent>((event, emit) {});
    on<EmailRegister>((event, emit) async {
      emit(RegisterLoading());
      await Future.delayed(Duration(seconds: 5));

      var response =
          await registerRepository.registerAccount(event.email, event.password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterError(error: response.body));

        print("Done");
      }
    });
  }
}
