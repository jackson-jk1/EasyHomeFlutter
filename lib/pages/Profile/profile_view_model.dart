import 'dart:developer';
import 'dart:io';
import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';


class ProfileViewModel extends GetxController {
  final UserController injectedLoginRegisterController;

  ProfileViewModel({required this.injectedLoginRegisterController});


  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController telefoneController = TextEditingController(text: "");
  final TextEditingController nomeController = TextEditingController(text: "");



validateForm(BuildContext context, File? file) {
    if (formKey.currentState!.validate()) {
      updateUser(context, file);
    }
 }


String? validateEmail(String? email) {
  return injectedLoginRegisterController.validateEmail(emailController.text);
}

  String? validateCellphone(String? cellphone) {
    if (cellphone == null || cellphone.isEmpty) {
      return 'Campo Telefone não pode ser nulo';
    }
    if (cellphone.length < 6) return 'Telefone invalido';
  }

String? validateName(String? name) {
  return injectedLoginRegisterController.validateName(nomeController.text);
}

  Future<User> processProfile() async {
    return injectedLoginRegisterController.getProfile();
  }
  Future pickImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
    } on PlatformException catch(e){
      print('Falha na escolha da imagem: $e');
    }}

  void editProfile(BuildContext context) {

       Get.offAllNamed(AppRoutes.editProfile);
    }

  updateUser(BuildContext context, File? file) async {
    User newUserModel = User (
        id: 0,
        email: emailController.value.text,
        password: "*********",
        name: nomeController.value.text,
        cellPhone: telefoneController.value.text,
        image: ''
    );
    final response = await injectedLoginRegisterController.updateUser(file, newUserModel);

    if (response.statusCode == 201) {
      log('Retornou 201');
      success(context, response.response);
    } else if (response.statusCode == 200) {
      log('Retornou 200');
      success(context, response.response);
    }
    else{
      errorUpdate(context, response.response);
      log('erro api');
    }
  }

  Future<String?> success(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Atenção!'),
        content: response != null
            ? Text(response)
            : Text('Erro no cadastro de novo usuário, verifique as informações preenchidas novamente.'),
        actions: [
          TextButton(
            onPressed: () => {Navigator.pop(context, 'OK'),
              Get.offAllNamed(AppRoutes.profile)
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Future<String?> errorUpdate(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Atenção!'),
        content: response != null
            ? Text(response)
            : Text('Erro no cadastro de novo usuário, verifique as informações preenchidas novamente.'),
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
}