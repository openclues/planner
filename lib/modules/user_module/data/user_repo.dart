import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planner/config/api_config/api_endpoints.dart';
import 'package:planner/config/api_config/api_helper.dart';

class UserRepo {
  Future<Response> updateUserInformation(String? firstName, String? lastName,
      String? email, String? phoneNumber) async {
    var response = await RequestHelper.put(ApiEndpoints.userData, {
      "first_name": firstName,
      "last_name": lastName,
      // "email": email,
      // "phone_number": phoneNumber,
    });
    return response;
  }

  Future<Response> updateProfilePictuer({required XFile profilePicture}) async {
    var response =
        await RequestHelper.putMultipart(ApiEndpoints.userData, profilePicture);
    print(response.body);
    return response;
  }
}
