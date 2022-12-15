import 'package:easy_home_app/widgets/build_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import 'login_register_view_model.dart';


class LoginPage extends GetWidget<LoginViewModel>{
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'imagens/FlutterA.png',
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
                            controller.images != null ?
                            Visibility(
                              visible: controller.switchLogin.value,
                              child:  ClipOval(
                                child: Image.file(
                                  controller.images!,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ) : Visibility(
                              visible: controller.switchLogin.value,
                              child: ClipOval(
                                child: Image.asset(
                                  'imagens/no_user.jpg',
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ),
                            const SizedBox(height: 14),
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: buildButton(
                                  title: 'Galeria',
                                  icon: Icons.image_outlined,
                                  onClicked: () => controller.getImage(context,ImageSource.gallery),
                                ),
                            ),
                            const SizedBox(height: 14),
                            Visibility(
                              visible: controller.switchLogin.value,
                              child: buildButton(
                                title: 'Camera',
                                icon: Icons.camera_alt_outlined,
                                onClicked: () => controller.getImage(context,ImageSource.camera),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Entrar',
                                    style: TextStyle(color: Colors.white)),
                                FlutterSwitch(
                                 height: 20.0,
                                 width: 40.0,
                                 toggleSize: 15.0,
                                 borderRadius: 10.0,
                                 activeColor: AppColors.yellow,
                                 value: controller.switchLogin.value,
                                 onToggle: (_) => controller.changeSwitchLogin(),
                                ),
                                const Text('Cadastrar',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(

                                onPressed: () =>  controller.switchLogin.value
                                    ? controller.validateRegister(context)
                                    : controller.validateForm(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.yellow,
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
