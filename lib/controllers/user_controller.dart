import 'package:easy_home_app/models/token_model.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import '../provider/api/http_client.dart';
import 'dart:developer' as dev;

class UserController {
  final HttpClient injectedHttp;
  final StorageKeys injectedStorage;

  UserController({required this.injectedHttp, required this.injectedStorage});

  Future<TokenModel?> makeLogin(String email, String senha) async {
    try {
      final response = await injectedHttp.post(
          url: "${injectedHttp.apiUrl()}/v1/user/auth",
          header: {'Content-Type': 'application/json; charset=UTF-8'},
          body: {
            "email" : email,
            "password" : senha
          });
      if (response.statusCodeIsOk) return TokenModel.fromJson(response.body);
      else return null;
    } catch (e) {
      rethrow;
    }
  }

}