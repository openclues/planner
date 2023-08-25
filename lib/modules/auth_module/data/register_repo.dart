import 'package:http/http.dart';
import 'package:planner/config/api_config/api_endpoints.dart';
import 'package:planner/config/api_config/api_helper.dart';

class RegisterRepository {
  Future<Response> registerAccount(String email, String password) async {
    var response = await RequestHelper.post(
        ApiEndpoints.register, {"email": email, "password": password});
    return response;
  }
}
