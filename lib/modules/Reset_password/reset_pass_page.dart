import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/services.dart';
import 'reset_pass_view_model.dart';
import 'package:get/get.dart';

import '../../menu_layout.dart';

class ResetPassword extends GetWidget<ResetPasswordViewModel> {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
          Scaffold(
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            child: Text("Recuperar Senha", style: TextStyle(
                              color: AppColors.white, fontSize: 24,),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Informe o email cadastrado:",
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 16),),
                          ),
                          TextFormField(
                            style: TextStyle(color: AppColors.white),
                            controller: controller.emailController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              filled: true,
                              fillColor: Color.fromRGBO(33, 39, 74, 1.0),
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(61, 59, 59, 1.0),
                                    width: 0.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(61, 59, 59, 1.0),
                                    width: 0.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.0)),

                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50.0)),
                              ),
                            ),
                            validator: (email) =>
                                controller.validateEmail(email),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: ()=> controller.validateForm(),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      Get.width, Get.height * 0.05)),
                              child:
                              Text("Enviar"))
                        ],
                      ),),

                  ],
                ),
              ),
            ),
          ),


      ),
    );
  }
}