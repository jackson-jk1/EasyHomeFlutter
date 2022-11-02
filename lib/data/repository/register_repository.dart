import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../model/new_user_model.dart';
import '../provider/api/http_client.dart';
import 'package:http/http.dart' as http;

class RegisterRepository {
  final HttpClient Http;

  RegisterRepository({required this.Http});

  Future<String> makeNewUser(NewUserModel user, File? file) async {
    try {
      var request =
      http.MultipartRequest('POST', Uri.parse("${Http.apiUrl()}/v1/user"));

        request.fields['Name'] = user.name.toString();
        request.fields['CellPhone'] = user.telefone.toString();
        request.fields['Email'] = user.email.toString();
        request.fields['Password'] = user.password.toString();

        request.files.add(http.MultipartFile.fromBytes(
            'Image', File(file!.path).readAsBytesSync(), filename: file!
            .path
            .split('/')
            .last));
        var res = await request.send();
        var resBody = await http.Response.fromStream(res);
        final responseData = jsonDecode(resBody.body);
        return (responseData.toString());
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}