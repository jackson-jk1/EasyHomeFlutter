import 'dart:convert';
import 'dart:io';

import 'package:easy_home_app/models/generic_response_model.dart';
import 'package:easy_home_app/models/token_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import '../provider/api/http_client.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class UserController {
  final HttpClient injectedHttp;
  final StorageKeys injectedStorage;

  UserController({required this.injectedHttp, required this.injectedStorage});

  Future<TokenModel?> makeLogin(String email, String senha) async {
    try {
      final response = await injectedHttp.post(
          url: "${injectedHttp.apiUrl()}/v1/user/auth",
          header: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: {
            "email": email,
            "password": senha
          });
      if (response.statusCodeIsOk)
        return TokenModel.fromJson(response.body);
      else
        return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<GenericResponse> makeNewUser(File? file, User user) async {
    var request =
    http.MultipartRequest(
        'POST', Uri.parse('${injectedHttp.apiUrl()}/v1/user'));

    request.fields['Name'] = user.name.toString();
    request.fields['CellPhone'] = user.cellPhone.toString();
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

    return GenericResponse.fromJson(responseData);
  }

  Future<GenericResponse> updateUser(File? file, User user) async {
    String? retorno = await injectedStorage.readToken();
    var request =
    http.MultipartRequest('Put', Uri.parse('${injectedHttp.apiUrl()}/v1/user'));


    request.fields['Name'] = user.name.toString();
    request.fields['CellPhone'] = user.cellPhone.toString();
    request.fields['Email'] = user.email.toString();
    request.fields['Password'] = user.password.toString();
    if (file != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'Image', File(file!.path).readAsBytesSync(), filename: file!
          .path
          .split('/')
          .last));
    }
    request.headers['Authorization'] = "Bearer ${retorno}";

    var res = await request.send();
    var resBody = await http.Response.fromStream(res);
    dev.log(resBody.toString());
    final responseData = jsonDecode(resBody.body);

    return GenericResponse.fromJson(responseData);
  }

  Future<GenericResponse> sendEmail(String email) async {
    try {

      final response = await injectedHttp.put(
        url: "${injectedHttp.apiUrl()}/v1/user/$email",
        header: {'Content-Type': 'text/plain; charset=UTF-8'},
        body: {},
      );
      return GenericResponse.fromJson(response.body);

      //throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  changePassword(Map<String, String> updatePassword) async{
    try {
      String? retorno = await injectedStorage.readToken();
      final response = await injectedHttp.put(
        url: "${injectedHttp.apiUrl()}/v1/user/password",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'},
        body: updatePassword,
      );
      return GenericResponse.fromJson(response.body);

      //throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getProfile() async {
    try {
      String? retorno = await injectedStorage.readToken();
      final response = await injectedHttp.get(
          url: "${injectedHttp.apiUrl()}/v1/user",
          header: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${retorno}',
          });

      return User.fromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty)
      return "Campo Email não pode ser nulo";

    var emailPattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    var emailRegExp = RegExp(emailPattern);
    if (!emailRegExp.hasMatch(email)) {
      return "Insira um email válido";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Campo senha não pode ser nulo';
    }
    var passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[!@#<>?":_`~;[\]\\|=+)(*&^%$-])(?=.*[a-z])(?=.*[0-9]).{8,}$');
    if (!passwordRegExp.hasMatch(password)) {
      return "A senha deve ter pelo menos 8 caracteres, com 1 letra \nmaiúscula, 1 letra minúscula, 1 número e 1 caractere \nespecial";
    }
    return null;
  }

  String? validateCellphone(String? cellphone) {
    dev.log('aki');
    if (cellphone == null || cellphone.isEmpty) {
      return 'Campo Telefone não pode ser nulo';
    }
    var phoneNumberPattern = r'^\([0-9]{2}\) [0-9]{5}-[0-9]{4}$';
    var phoneNumberRegExp = RegExp(phoneNumberPattern);
    if (!phoneNumberRegExp.hasMatch(cellphone)) {
      return "Formato invalido";
    }
    return null;
  }


  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Campo Nome não pode ser nulo';
    }
    if (name.length < 6) return 'Nome invalido';
  }

  String? validateCpf(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Campo Cpf não pode ser nulo';
    }
    var cpfPattern = r"^[0-9]{11}$";
    final cpfRegExp = RegExp(cpfPattern);
    if (!cpfRegExp.hasMatch(cpf)) {
      return "Insira um CPF válido sem pontuação";
    }
    return null;
  }

}


