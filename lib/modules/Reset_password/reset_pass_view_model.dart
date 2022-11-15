import 'dart:convert';
import 'dart:developer';

import 'package:easy_home/data/model/login_model.dart';
import 'package:easy_home/shared/widgets/error_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/repository/reset_pass_repository.dart';
import '../../routes/app_routes.dart';


class ResetPasswordViewModel extends GetxController {

  final ResetPasswordRepository injectedPasswordRepository;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordViewModel({required this.injectedPasswordRepository});


  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Campo Email não pode ser nulo';

    return null;
  }


  validateForm() {
    if (formKey.currentState!.validate()) {
      processEmail();
    }
  }

  processEmail() async {

      await sendEmail(emailController.value.text);

  }

  sendEmail(String email) async {
    LoginModel loginModel = LoginModel(
        email: '',
        password: '');
    final bool check = await injectedPasswordRepository.sendEmail(email, loginModel);
    Get.offAllNamed(AppRoutes.login);
  }



}