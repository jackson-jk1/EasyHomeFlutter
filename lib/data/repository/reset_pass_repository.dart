import 'dart:developer';

import '../model/login_model.dart';
import '../provider/api/http_client.dart';

class ResetPasswordRepository {
  final HttpClient http;
  ResetPasswordRepository({required this.http});

  Future<bool> sendEmail(String email, LoginModel login) async {
    try {
      final response = await http.put(
          url: "${http.apiUrl()}/v1/user/$email",
          header: {'Content-Type': 'text/plain; charset=UTF-8'},
          body: login.toJson(),
      );
      log(response.statusCode.toString());
      if (response.statusCodeIsOk) return true;

      throw Exception();
    } catch (e) {
      rethrow;
    }
  }


}