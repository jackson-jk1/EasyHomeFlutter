import 'dart:convert';
import 'dart:developer';

import 'package:easy_home/shared/widgets/error_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/model/login_model.dart';
import '../../data/model/auth_model.dart';
import '../../data/repository/login_repository.dart';
import '../../routes/app_routes.dart';


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

  validateForm() {
    if (formKey.currentState!.validate()) {
      //Get.offAllNamed(AppRoutes.realEstateList);
      processLogin();
    }
  }

  processLogin() async {
    try {
      await createLogin();
    } catch (e) {
      log("Ocorreu um erro");
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