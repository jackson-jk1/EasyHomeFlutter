import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:easy_home_app/models/contact_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

class ContactViewModel extends GetxController {

  final UserController injectedContactController;

  ContactViewModel({required this.injectedContactController});


  Future<List<Contact>> listContacts() async {
    return await injectedContactController.listContacts();
  }

  Future<User> getContact(int id) async {
    return injectedContactController.getContact(id);
  }

  removeContact(int contactId, BuildContext context) async {
    var response = await injectedContactController.removeContact(contactId);
    if (response != 200) {
      errorRegister(context, "Erro ao remover Contato");
    }
  }

  Future<String?> errorRegister(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Atenção!'),
            content: response != null
                ? Text(response)
                : const Text(
                'Erro Interno tente novamente mais tarde'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                {Navigator.pop(context, 'OK'),
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}