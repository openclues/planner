import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:planner/modules/user_module/data/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo = UserRepo();
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateUserInformationEvent>((event, emit) async {
      emit(UpdateUserInformationLoading());
      var response = await userRepo.updateUserInformation(
        event.firstName,
        event.lastName,
        event.email,
        event.phoneNumber,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateUserInformationLoaded());
      } else {
        emit(UpdateUserInformationError());
      }
    });
    on<UpdateUserImageEvent>((event, emit) async {
      emit(UpdateUserImageLoading());
      var response =
          await userRepo.updateProfilePictuer(profilePicture: event.image!);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateUserImageLoaded());
      } else {
        emit(UpdateUserImageError(error : "Error Uploading Image \n You can upload it later"));
      }
    });
  }
}
