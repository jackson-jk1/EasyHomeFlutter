import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_home/shared/widgets/error_dialog.dart';
import 'package:date_field/date_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/login_model.dart';
import '../../data/model/auth_model.dart';
import '../../data/model/new_user_model.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/login_repository.dart';
import '../../routes/app_routes.dart';
import './controller.dart';


class LoginViewModel extends GetxController {
  final LoginRepository injectedLoginRepository;
  final AuthModel injectedAuthModel;

  LoginViewModel({required this.injectedLoginRepository, required this.injectedAuthModel});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();

  final controller = Controller();

  RxBool switchLogin = false.obs;

  changeSwitchLogin() => switchLogin.toggle().value;

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

  validateForm(File? file) {
    if (formKey.currentState!.validate()) {
      //Get.offAllNamed(AppRoutes.realEstateList);
      processLogin();
      Get.offAllNamed(AppRoutes.realEstateList);
      //sendToApi(file);
      //processLogin();
    }
  }

  Future<bool?> validateRegister(BuildContext context, File? file) async {
    log("Entrou no validateRegister");
    try{
      NewUserModel newUserModel = NewUserModel(
          email: emailController.value.text,
          password: passwordController.value.text,
          name: nomeController.value.text,
          telefone: telefoneController.value.text,
          image: ''
      );
      sendToApi(context, file);
    } catch (e) {
      log("Erro ao enviar dados para a API");
      log(e.toString());
    }
    return null;
  }

  processLogin() async {
    try {
      await createLogin();
    } catch (e) {
      log("Ocorreu um erro");
    }
  }

  sendToApi(BuildContext context, File? file) async {
    try{
      NewUserModel newUserModel = NewUserModel(
        email: emailController.value.text,
        password: passwordController.value.text,
        name: nomeController.value.text,
        telefone: telefoneController.value.text,
        image: ''
      );
      if (await controller.uploadImage(file, newUserModel)){
        success(context);
      }
      else{
        error(context);
      }
    } catch (e) {
      log("Erro ao enviar dados para a API");
    }
  }

  createLogin() async {
    LoginModel loginModel = LoginModel(
        email: emailController.value.text,
        password: passwordController.value.text);
    makeLogin(loginModel);
  }

  makeLogin(LoginModel loginModel) async {
    final authModel = await injectedLoginRepository.makeLogin(loginModel);
      initSession(authModel);
      Get.offAllNamed(AppRoutes.realEstateList);
  }



  initSession(AuthModel authModel) async {
    //injectedUserModel.id = userModel.id;
    injectedAuthModel.token = authModel.token;
    //injectedUserModel.email = userModel.email;
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
Future<String?> success(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: const Text('Conta criada com sucesso!'),
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
Future<String?> error(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: const Text('Erro na criação da conta!'),
      actions: <Widget>[
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