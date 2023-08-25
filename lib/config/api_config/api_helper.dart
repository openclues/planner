import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../auth_token_handler.dart';
import 'api_endpoints.dart';

class RequestHelper {
  static String? _token;

  static setAuthTokenToNull() {
    _token = null;
  }

  static Future<String?> getAuthToken() async {
    if (_token != null) {
      return _token;
    }
    _token = await AuthTokenSaveAndGet.getAuthToken();

    return _token;
  }

  static Future<http.Response> get(String endpoint) async {
    String url = endpoint;
    print(url);
    String? authToken = await getAuthToken();

    if (authToken != null) {
      // Authenticated request with header
      var response = await http
          .get(Uri.parse(url), headers: {"Authorization": "Token $authToken"});
      return response;
    } else {
      var response = await http.get(Uri.parse(url));

      return response;
    }
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data,
      {bool? signup}) async {
    String url = endpoint;

    Map<String, String> headers = {"Content-Type": "application/json"};
    if (signup == true) {
      return http.post(Uri.parse(url), body: data);
    } else {
      String? authToken = await getAuthToken();
      if (authToken != null) {
        // authenticated request with header
        headers["Authorization"] = "Token $authToken";

        return http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));
      } else {
        try {
          return http.post(Uri.parse(url), body: data);
        } catch (e) {}
        return http.post(Uri.parse(url), body: data);
      }
    }
  }

  static Future<http.Response> put(String endpoint, dynamic data) async {
    String url = endpoint;

    String? authToken = await getAuthToken();

    if (authToken != null) {
      // authenticated request with header
      return http.patch(Uri.parse(url),
          headers: {"Authorization": "Token $authToken"}, body: data);
    } else {
      // unauthenticated request without header
      return http.put(Uri.parse(url), body: json.encode(data));
    }
  }

  static Future<http.Response> putMultipart(String endpoint, XFile file) async {
    String url = endpoint;
    String? authToken = await getAuthToken();

    var request = http.MultipartRequest('PUT', Uri.parse(url));

    // Determine the file's MIME type

    // Create a multipart file from the XFile
    var multipartFile = await http.MultipartFile.fromPath(
      'profile_pic',
      file.path,
    );

    // Add the file to the request
    request.files.add(multipartFile);

    if (authToken != null) {
      // Add authorization header
      request.headers['Authorization'] = 'Token $authToken';
    }

    // Send the request and receive the response
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  static Future<http.Response> delete(String endpoint, dynamic data) async {
    String url = endpoint;
    String? authToken = await getAuthToken();

    if (authToken != null) {
      // authenticated request with header

      return http.delete(Uri.parse(url),
          headers: {"Authorization": "Token $authToken"}, body: data);
    } else {
      // unauthenticated request without header
      return http.delete(Uri.parse(url), body: data);
    }
  }
}
