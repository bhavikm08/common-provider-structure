import 'package:http/http.dart' as http;

import '../Api_Service/api_service.dart';
import '../Common/api_constant.dart';

class AuthRepository {
  AuthRepository._privateConstructor();
  static final AuthRepository instance = AuthRepository._privateConstructor();
  //  callLogin({required String email, required String password}) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'multipart/form-data',
  //   };
  //   var formData = {
  //     'username': email,
  //     'password': password,
  //   };
  //   return await apiService.request(
  //     endPoint: ApiConstant.loginApi,
  //     method: Method.MULTIPART,
  //     reqBody: formData,
  //     headers: headers,
  //   );
  // }

  Future<http.Response> callLogin({
    required String email,
    required String password,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var formData = {
      'username': email,
      'password': password,
    };
    return await ApiService.instance.request(
      endPoint: ApiConstant.loginApi,
      method: Method.MULTIPART,
      reqBody: formData,
      headers: headers,
    );
  }

  Future<http.Response> getUserList(
  {String endPoint = ''}) async {
    return await ApiService.instance.request(
      endPoint: endPoint,
      method: Method.GET,
    );
  }
}
