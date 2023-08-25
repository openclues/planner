import 'package:http/http.dart';
import 'package:planner/config/api_config/api_endpoints.dart';
import 'package:planner/config/api_config/api_helper.dart';

class LoadingRepo {
  //check user's information
  Future<Response> checkUserLogin() async {
    var response = await RequestHelper.get(ApiEndpoints.userData);
    return response;
  }
}
