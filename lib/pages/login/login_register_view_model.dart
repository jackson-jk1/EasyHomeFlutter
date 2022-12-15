import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:easy_home_app/models/token_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';



class LoginViewModel extends GetxController{
  final UserController injectedLoginRegisterController;

  LoginViewModel({required this.injectedLoginRegisterController});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  File? images;

  RxBool switchLogin = false.obs;

  changeSwitchLogin() => switchLogin.toggle().value;

  Future<File?> getImage(BuildContext context ,ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return null;
    //TO convert Xfile into file
    images = File(image.path);
    (context as Element).markNeedsBuild();
    return images;
  }

  validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      makeLogin(context);
    }
  }


  makeLogin(BuildContext context) async {
    final authModel = await injectedLoginRegisterController.makeLogin(emailController.text, passwordController.text);
    if (authModel == null) {
      log('Retornou null');
      errorLogin(context);
    }
    else{
      initSession(authModel);
      Get.offAllNamed(AppRoutes.realEstateList);
    }
  }

  initSession(TokenModel token) async {
    String? retorno = await injectedLoginRegisterController.injectedStorage.readToken();
    injectedLoginRegisterController.injectedStorage.store(token: token.token);
  }
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Campo Email não pode ser nulo';

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Campo senha não pode ser nulo';
    }

    if (password.length < 6) return 'Senha muito pequena';

    return null;
  }


  Future<bool?> validateRegister(BuildContext context) async {
    if (images == null) {
      errorImageRegister(context);
    }
    else {
      log("Entrou no validateRegister");
      try {
      } catch (e) {
        log("Erro ao enviar dados para a API");
        log(e.toString());
      }
      return null;
    }
  }


  String? validateCellphone(String? cellphone) {
    if (cellphone == null || cellphone.isEmpty) {
      return 'Campo Telefone não pode ser nulo';
    }
    if (cellphone.length < 6) return 'Telefone invalido';
   }


  String? validateCpf(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Campo Cpf não pode ser nulo';
    }
    if (cpf.length < 6) return 'Cpf invalido';
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Campo Nome não pode ser nulo';
    }
    if (name.length < 6) return 'Nome invalido';
  }
}

@override
Future<String?> success(BuildContext context, String? response) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: response != null
          ? Text(response)
          : Text('Erro no cadastro de novo usuário, verifique as informações preenchidas novamente.'),
      actions: [
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK'),
            Get.offAllNamed(AppRoutes.login)
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

@override
Future<String?> errorRegister(BuildContext context, String? response) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: response != null
            ? Text(response)
            : Text('Erro no cadastro de novo usuário, verifique as informações preenchidas novamente.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK'),
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
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Erro!'),
      content: Text('Foto de perfil não escolhida, verifique as informações preenchidas novamente.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK'),
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
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: Text('E-mail ou senha incorretos.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK')
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

