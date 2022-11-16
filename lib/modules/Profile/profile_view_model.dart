import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_home/data/model/generic_response_model.dart';
import 'package:easy_home/data/repository/user_repository.dart';
import 'package:easy_home/shared/widgets/error_dialog.dart';
import 'package:date_field/date_field.dart';
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

  processProfile() async {
    try {
      final userModel = await injectedUserRepository.getProfile();
      if (userModel == null) {
        log('Retornou null');
      }
      else{
        log(userModel.image);
        log(userModel.name);
        log(userModel.email);
        log(userModel.cellPhone);
        log(userModel.id.toString());
        log(userModel.userPreferences.toString());
      }
      //var userModel = injectedUserRepository.getProfile();
      //log(userModel.toString());
    } catch (e) {
      log("Ocorreu um erro");
    }
  }
}