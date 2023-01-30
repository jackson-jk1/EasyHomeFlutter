import 'dart:convert';
import 'dart:developer';

import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';


class ResetPasswordViewModel extends GetxController {

  final UserController injectedLoginRegisterController;

  ResetPasswordViewModel({required this.injectedLoginRegisterController});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();



  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Campo Email não pode ser nulo';

    return null;
  }


  validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      processEmail(context);
    }
  }

  processEmail(BuildContext context) async {

      await sendEmail(emailController.value.text, context);

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