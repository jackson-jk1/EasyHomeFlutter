import 'dart:io';

import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:date_field/date_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'login_view_model.dart';

final List<Map<String, dynamic>> _items = [
  {
    'value': 'm',
    'label': 'M',
  },
  {
    'value': 'f',
    'label': 'F',
  },
];

//File? images;

class LoginPage extends GetWidget<LoginViewModel>{
  LoginPage({Key? key}) : super(key: key);
  File? images = null;

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(46),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      );

  @override
  Widget build(BuildContext context) {

    Future<File?> getImage(ImageSource source) async {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;
      //TO convert Xfile into file
      this.images = File(image!.path);
      (context as Element).markNeedsBuild();

      return images;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        return
          SingleChildScrollView(
             reverse: true,
             child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/LOGO.png',
                       width: 200,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                style: TextStyle(color: AppColors.white),
                                controller: controller.emailController,
                                textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(labelText: 'E-mail *',
                                  filled: true,
                                  fillColor: Color.fromRGBO(33, 39, 74,1.0),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                   enabledBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                ),
                              ),
                              validator: (email) => controller.validateEmail(email),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                textInputAction: TextInputAction.next,
                                style: TextStyle(color: AppColors.white),
                                decoration:
                                const InputDecoration(labelText: 'Senha *',
                                  filled: true, //<-- SEE HERE
                                  fillColor: Color.fromRGBO(33, 39, 74,1.0),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  enabledBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),),

                                obscureText: true,
                                validator: (password) => controller.validatePassword(password),
                                controller: controller.passwordController
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(

                                visible: controller.switchLogin.value,
                                child: TextFormField(
                                    style: TextStyle(color: AppColors.white),
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(labelText: 'Confirmar Senha *',
                                      filled: true, //<-- SEE HERE
                                      fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                                      labelStyle: TextStyle(color: Colors.white),
                                      border:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      ),
                                      enabledBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                      ),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      ),),
                                    obscureText: true,
                                    validator: (Pconfirm) => controller.validatePassword(Pconfirm),
                                    controller: controller.passwordConfirmController
                                )
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(
                                visible: controller.switchLogin.value,
                                child: TextFormField(
                                    style: TextStyle(color: AppColors.white),
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(labelText: 'Nome *',
                                      filled: true, //<-- SEE HERE
                                      fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                                      labelStyle: TextStyle(color: Colors.white),
                                      border:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      ),
                                      enabledBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),

                                      ),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                      ),),
                                    validator: (Nome) => controller.validateName(Nome),
                                    controller: controller.nomeController
                                )
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(
                                visible: controller.switchLogin.value,
                                child: TextFormField(
                                  style: TextStyle(color: AppColors.white),
                                  controller: controller.telefoneController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(labelText: 'Telefone *',
                                    filled: true, //<-- SEE HERE
                                    fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                                    labelStyle: TextStyle(color: Colors.white),
                                    border:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    enabledBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),

                                  ),
                                  validator: (Telefone) => controller.validateCellphone(Telefone),
                              )
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            images != null ?
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: Image.file(
                                  images!,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                              )
                            ) : Visibility(
                              visible: controller.switchLogin.value,
                              child: Image.asset(
                                'images/no_user.jpg',
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: buildButton(
                                  title: 'Galeria',
                                  icon: Icons.image_outlined,
                                  onClicked: () => getImage(ImageSource.gallery),
                                ),
                            ),
                            const SizedBox(height: 14),
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: buildButton(
                                title: 'Camera',
                                icon: Icons.camera_alt_outlined,
                                onClicked: () => getImage(ImageSource.camera),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Entrar',
                                    style: TextStyle(color: Colors.white)),

                                Switch(
                                  value: controller.switchLogin.value,
                                  onChanged: (_) => controller.changeSwitchLogin(),
                                ),
                                const Text('Cadastrar',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                                onPressed: () => controller.validateForm(images),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(Get.width, Get.height * 0.05)),
                                child:
                                Text(controller.switchLogin.value
                                    ? 'Cadastrar'
                                    : 'Entrar'))
                          ],
                        ),
                    ),
                  ],
                ),
              ),
          );
      }),
    );
  }
}
