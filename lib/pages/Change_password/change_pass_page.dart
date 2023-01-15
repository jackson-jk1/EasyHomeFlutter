import 'dart:io';

import 'package:easy_home_app/routes/app_routes.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'change_pass_view_model.dart';
import 'package:get/get.dart';

import '../../menu_layout.dart';

class ChangePassword extends GetWidget<ChangePasswordViewModel> {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      home: Scaffold(
        drawer: MenuDashboardPage(),
        appBar: AppBar(
            backgroundColor: AppColors.background,
            title: const Text("")),
        backgroundColor: AppColors.pages,
        body: WillPopScope(
          onWillPop: () async {
          return false;
          },
          child: Scaffold(
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
                            child: Text("Alterar Senha", style: TextStyle(
                              color: AppColors.white, fontSize: 24,),),
                          ),
                          TextFormField(
                            style: TextStyle(color: AppColors.white),
                            controller: controller.oldPasswordController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Senha Atual',
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
                            validator: (oldPassword) =>
                                controller.validatePassword(oldPassword),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: TextStyle(color: AppColors.white),
                            controller: controller.passwordController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Nova Senha',
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
                            validator: (newPassword) =>
                                controller.validatePassword(newPassword),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: TextStyle(color: AppColors.white),
                            controller: controller.confirmPasswordController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Confirmar senha',
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
                            validator: (confirPassword) =>
                                controller.confirmPassword(confirPassword),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                              onPressed: ()=> controller.validateForm(context),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow,
                                  minimumSize: Size(Get.width, Get.height * 0.05)),
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
    )
    );
  }
}