import 'dart:convert';
import 'dart:developer';

import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';


class ChangePasswordViewModel extends GetxController {

  final UserController injectedLoginRegisterController;

  ChangePasswordViewModel({required this.injectedLoginRegisterController});
  final formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  String? validatePassword(String? password) {
    return injectedLoginRegisterController.validatePassword(password);
  }

  String? confirmPassword(String? confirmPassword) {

    if (confirmPassword == passwordController.text) {
     return null;
    }
    return "Senhas não coencidem";
  }

  validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      processPassword(context);
    }
  }

  processPassword(BuildContext context) async {
      var updatePassword = {
        "passwordOld": oldPasswordController.text,
        "passwordNew": passwordController.text,
        "passwordConfirm": confirmPasswordController.text
      };
      await changePassword(updatePassword, context);

  }

  sendEmail(String email, BuildContext context) async {

    final response = await injectedLoginRegisterController.sendEmail(email);
    if (response.statusCode == 200) {
      successResetPass(context, response.response);
    }
    else{
      errorResetPass(context, response.response);
    }
  }

  changePassword(Map<String, String> updatePassword, BuildContext context) async{
    final response = await injectedLoginRegisterController.changePassword(updatePassword);
    if (response.statusCode == 200) {
      successResetPass(context, response.response);
    }
    else{
      errorResetPass(context, response.response);
    }
  }


}

@override
Future<String?> successResetPass(BuildContext context, String? response) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Sucesso!'),
      content: response != null
          ? Text(response)
          : Text('Erro no reset da senha, verifique o e-mail preenchido e tente novamente.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => {Navigator.pop(context, 'OK'),
          Get.offAllNamed(AppRoutes.login),
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

@override
Future<String?> errorResetPass(BuildContext context, String? response) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: response != null
          ? Text(response)
          : Text('Erro no reset da senha, verifique o e-mail preenchido e tente novamente.'),
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