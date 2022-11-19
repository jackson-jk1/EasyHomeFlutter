import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_home/data/model/generic_response_model.dart';
import 'package:easy_home/data/repository/user_repository.dart';
import 'package:easy_home/shared/widgets/error_dialog.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/login_model.dart';
import '../../data/model/auth_model.dart';
import '../../data/model/new_user_model.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/user_repository.dart';
import '../../routes/app_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ProfileViewModel extends GetxController {
  final UserRepository injectedUserRepository;

  ProfileViewModel({required this.injectedUserRepository});

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  Future<UserModel> processProfile() async {
    return injectedUserRepository.getProfile();
  }
  Future pickImage(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      //return imageTemporary;
      //setState(() => images = imageTemporary);
    } on PlatformException catch(e){
      print('Falha na escolha da imagem: $e');
    }}

  void editProfile(BuildContext context) {

       Get.offAllNamed(AppRoutes.editProfile);
    }

  updateUser(BuildContext context, File? file) async {
    //try{
    NewUserModel newUserModel = NewUserModel(
        email: emailController.value.text,
        password: "*********",
        name: nomeController.value.text,
        telefone: telefoneController.value.text,
        image: ''
    );
    final response = await injectedUserRepository.updateUser(file, newUserModel);

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