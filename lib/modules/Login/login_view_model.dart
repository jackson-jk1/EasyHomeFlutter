import 'dart:developer';
import 'dart:io';


import 'package:date_field/date_field.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/login_model.dart';
import '../../data/model/new_user_model.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/login_repository.dart';
import '../../routes/app_routes.dart';
import './controller.dart';

class LoginViewModel extends GetxController {
  final LoginRepository injectedLoginRepository;
  final UserModel injectedUserModel;

  LoginViewModel({required this.injectedLoginRepository, required this.injectedUserModel});

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
      return 'Campo password não pode ser nulo';
    }

    if (password.length < 6) return 'Password muito pequena';

    return null;
  }

  validateForm(File? file) {
    if (formKey.currentState!.validate()) {
      Get.offAllNamed(AppRoutes.realEstateList);
      sendToApi(file);
      //processLogin();
    }
  }

  processLogin() async {
    try {
      await createLogin();
    } catch (e) {
      log("Ocorreu um erro");
    }
  }

  sendToApi(File? file) async {
    try{
      NewUserModel newUserModel = NewUserModel(
        email: emailController.value.text,
        password: passwordController.value.text,
        name: nomeController.value.text,
        telefone: telefoneController.value.text,
        image: ''
      );
      controller.uploadImage(file, newUserModel);
      /*log(newUserModel.email);
      log(newUserModel.password);
      log(newUserModel.name);
      log(newUserModel.telefone);*/
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
    final userModel = await injectedLoginRepository.makeLogin(loginModel);
    initSession(userModel);
    Get.offAllNamed(AppRoutes.realEstateList);
  }

  initSession(UserModel userModel) {
    injectedUserModel.id = userModel.id;
    injectedUserModel.token = userModel.token;
    injectedUserModel.email = userModel.email;
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