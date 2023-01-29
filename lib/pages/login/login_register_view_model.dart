import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:easy_home_app/models/token_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';



class LoginViewModel extends GetxController {
  final UserController injectedLoginRegisterController;

  LoginViewModel({required this.injectedLoginRegisterController});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  File? images;

  RxBool switchLogin = false.obs;


  changeSwitchLogin() =>
      switchLogin
          .toggle()
          .value;

  Future<File?> getImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return null;
    //TO convert Xfile into file
    images = File(image.path);
    (context as Element).markNeedsBuild();
    return images;
  }

  registerNewUser(BuildContext context, File file) async {
    User newUserModel = User(
        id: 0,
        email: emailController.value.text,
        password: passwordController.value.text,
        name: nomeController.value.text,
        cellPhone: cellphoneController.value.text,
        image: ''
    );
    final response = await injectedLoginRegisterController.makeNewUser(
        file, newUserModel);
    if (response.statusCode == 201) {
      log('Retornou 201');
      success(context, response.response);
    } else if (response.statusCode == 200) {
      log('Retornou 200');
      success(context, response.response);
    }
    else {
      errorRegister(context, response.response);
      log('erro api');
    }
  }


  Future<String?> token () async{
    return await injectedLoginRegisterController.injectedStorage.readToken();
  }
  validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      makeLogin(context);
    }
  }

  String? validateEmail(String? email) {
    return injectedLoginRegisterController.validateEmail(emailController.text);
  }

  String? validateCellphone(String? cellphone) {
    return injectedLoginRegisterController.validateCellphone(cellphoneController.text);
  }

  String? validateName(String? name) {
    return injectedLoginRegisterController.validateName(nomeController.text);
  }

  String? validatePassword(String? cpf) {
    return injectedLoginRegisterController.validatePassword(passwordController.text);
  }

  makeLogin(BuildContext context) async {
    final authModel = await injectedLoginRegisterController.makeLogin(
        emailController.text, passwordController.text);
    if (authModel == null) {
      log('Retornou null');
      errorLogin(context);
    }
    else {
      initSession(authModel);
      Get.offAllNamed(AppRoutes.realEstateList);
    }
  }

  initSession(TokenModel token) async {
    String? retorno = await injectedLoginRegisterController.injectedStorage
        .readToken();
    injectedLoginRegisterController.injectedStorage.store(token: token.token);
  }


  Future<bool?> validateRegister(BuildContext context) async {
    if (images == null) {
      errorImageRegister(context);
    }
    else {
      bool termsAccepted = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmação de termos"),
            content: Text("Por favor aceite os termos de serviço"),
            actions: <Widget>[
              TextButton(
                child: Text("Aceitar"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: Text("Recusar"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        },
      );
      if (termsAccepted) {
        registerNewUser(context, images!);
        try {} catch (e) {
          log("Erro ao enviar dados para a API");
          log(e.toString());
        }
        return null;
      } else {
        return null;
      }
    }
  }


  Future<String?> success(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Atenção!'),
            content: response != null
                ? Text(response)
                : Text(
                'Erro no cadastro de novo usuário, verifique as informações preenchidas novamente.'),
            actions: [
              TextButton(
                onPressed: () =>
                {Navigator.pop(context, 'OK'),
                  Get.offAllNamed(AppRoutes.login)
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<String?> errorRegister(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Atenção!'),
            content: response != null
                ? Text(response)
                : Text(
                'Erro no cadastro de novo usuário, verifique as informações preenchidas novamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                {Navigator.pop(context, 'OK'),
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }


  @override
  Future<String?> errorImageRegister(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Erro!'),
            content: Text(
                'Foto de perfil não escolhida, verifique as informações preenchidas novamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                {Navigator.pop(context, 'OK'),
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Future<String?> errorLogin(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Atenção!'),
            content: Text('E-mail ou senha incorretos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                {Navigator.pop(context, 'OK')
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
