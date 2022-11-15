import 'dart:developer';

import '../model/generic_response_model.dart';
import '../model/login_model.dart';
import '../provider/api/http_client.dart';

class ResetPasswordRepository {
  final HttpClient http;
  ResetPasswordRepository({required this.http});

  Future<GenericResponseModel> sendEmail(String email, LoginModel login) async {
    try {
      log("${http.apiUrl()}/v1/user/$email");
      final response = await http.put(
          url: "${http.apiUrl()}/v1/user/$email",
          header: {'Content-Type': 'text/plain; charset=UTF-8'},
          body: login.toJson(),
      );
      log(response.statusCode.toString());
      //if (response.statusCodeIsOk)
      return GenericResponseModel.fromJson(response.body);

      //throw Exception();
    } catch (e) {
      rethrow;
    }
  }


}