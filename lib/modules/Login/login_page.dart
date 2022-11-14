import 'dart:io';

import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:date_field/date_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import '../../routes/app_routes.dart';
import 'login_view_model.dart';
import 'package:easy_home/shared/widgets/build_button.dart';

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


class LoginPage extends GetWidget<LoginViewModel>{
  const LoginPage({Key? key}) : super(key: key);
  //File? image = null;

  @override
  Widget build(BuildContext context) {
    File? images = null;

    Future pickImage(ImageSource source) async {
      try{
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;

        final imageTemporary = File(image.path);
        //return imageTemporary;
        //setState(() => images = imageTemporary);
      } on PlatformException catch(e){
        print('Falha na escolha da imagem: $e');
      }
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
                                visible: !controller.switchLogin.value,
                                child: InkWell(
                                    child: const Text('Esqueci minha senha', style: TextStyle(color: Colors.lightBlueAccent, fontSize: 12),),
                                    onTap: () => { Get.offAllNamed(AppRoutes.resetPassword)},
                                ),
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
                            Visibility(
                                visible: controller.switchLogin.value,
                                child: DateTimeFormField(
                                    decoration: const InputDecoration(labelText: 'Data de Nascimento *',
                                      filled: true, //<-- SEE HERE
                                      fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                                      labelStyle: TextStyle(color: Colors.white),
                                      suffixIcon: Icon(Icons.event_note, color: Colors.white),
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
                                  mode: DateTimeFieldPickerMode.date,
                                    onDateSelected: (DateTime value) {
                                      print(value);
                                    },
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
                                width: 150,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: buildButton(
                                  title: 'Galeria',
                                  icon: Icons.image_outlined,
                                  onClicked: () => pickImage(ImageSource.gallery),
                                ),
                            ),
                            const SizedBox(height: 14),
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: buildButton(
                                title: 'Camera',
                                icon: Icons.camera_alt_outlined,
                                onClicked: () => pickImage(ImageSource.camera),
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
                                onPressed: () => controller.validateForm(),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(Get.width, Get.height * 0.05)),
                                child:
                                Text(controller.switchLogin.value
                                    ? 'Cadastrar'
                                    : 'Entrar'))
                          ],
                        ),),

                  ],
                ),
              ),
          );
      }),
    );
  }
}
