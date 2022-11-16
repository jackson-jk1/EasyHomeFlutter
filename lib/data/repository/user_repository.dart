import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../model/new_user_model.dart';
import '../model/user_model.dart';
import '../provider/api/http_client.dart';
import '../provider/storage/storage_keys.dart';
import 'package:http/http.dart' as http;
import '../model/generic_response_model.dart';

class UserRepository {
  final HttpClient Http;
  final StorageKeys storage = new StorageKeys();

  UserRepository({required this.Http});

  Future<GenericResponseModel> makeNewUser(File? file, NewUserModel user) async {
    var request =
    http.MultipartRequest('POST', Uri.parse('${Http.apiUrl()}/v1/user'));

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
    log(responseData.toString());

    return GenericResponseModel.fromJson(responseData);

  }

  Future<UserModel?> getProfile() async {
    try {
      String? retorno = await storage.readToken();
      final response = await Http.get(
          url: "${Http.apiUrl()}/v1/user",
          header: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${retorno}',
          });

      log(retorno!);
      log(response.statusCode.toString());
      log(response.body.toString());
    if (response.statusCodeIsOk) return UserModel.fromJson(response.body);
    //if(response.statusCode == 401) return UserModel.fromJson(response.body);
    else return null;

    //throw Exception('AuthenticantionException');
    } catch (e) {
    rethrow;
    }
  }

  Future<String?> getToken(){
    return storage.readToken();
  }
}