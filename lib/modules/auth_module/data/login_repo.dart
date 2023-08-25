import 'package:http/http.dart';
import 'package:planner/config/api_config/api_endpoints.dart';
import 'package:planner/config/api_config/api_helper.dart';

class LoginRepo {
  Future<Response> emaillogin(String email, String password) async {
    var response = await RequestHelper.post(
        ApiEndpoints.login, {"email": email, "password": password});
    print(response.body);
    return response;
  }
}
