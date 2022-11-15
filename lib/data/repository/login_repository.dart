import 'package:easy_home/data/model/login_model.dart';
import 'package:easy_home/shared/widgets/error_dialog.dart';
import 'package:get/get.dart';
import '../model/auth_model.dart';
import '../provider/api/http_client.dart';

class LoginRepository {
  final HttpClient http;

  LoginRepository({required this.http});

  Future<AuthModel?> makeLogin(LoginModel loginModel) async {
    try {
      final response = await http.post(
          url: "${http.apiUrl()}/v1/user/auth",
          header: {'Content-Type': 'application/json; charset=UTF-8'},
          body: loginModel.toJson());
      if (response.statusCodeIsOk) return AuthModel.fromJson(response.body);
      else return null;

      //throw Exception('AuthenticantionException');
    } catch (e) {
      rethrow;
    }
  }

}