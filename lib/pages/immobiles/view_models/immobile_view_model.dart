import 'package:easy_home_app/controllers/immobile_controller.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

class ImmobileViewModel extends GetxController {

  final ImmobileController injectedImmobileController;

  ImmobileViewModel({required this.injectedImmobileController});


  Future<List<Immobile>> getImmobiles(Filters filters) async {
    return await injectedImmobileController.getImmobiles(filters);
  }

  Future<List<Polo>> getPolos() async {
    return await injectedImmobileController.getPolos();
  }

  Future<List<User>> getinterested(int immId) async {
    String? retorno = await injectedImmobileController.injectedStorage
        .readToken();
    final response = await injectedImmobileController.injectedHttp.get(
      url: "${injectedImmobileController.injectedHttp
          .apiUrl()}/v1/user/getByImm/${immId}",
      header: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${retorno}'},
    );

    dev.log(response.body.toString());
    var tagObjsJson = response.body['data'] as List;

    List<User> users = tagObjsJson.map((u) => User.fromJson(u)).toList();
    return users;
  }


  Future<bool> checkList(int immId) async {
    return await injectedImmobileController.checkList(immId);
  }

  void addPreference(int immId, BuildContext context, bool status) async {
    var response = status == true
        ? await injectedImmobileController.addFavorite(immId)
        : await injectedImmobileController.removeFavorite(immId);
    if (response != 200) {
      errorRegister(context, "Erro ao adicionar preferencia");
    }
  }

  void removePreference(int immId, BuildContext context) async {
    var response = await injectedImmobileController.removeFavorite(immId);
    if (response != 200) {
      errorRegister(context, "Erro ao remover preferencia");
    }
  }

  Future<void> goZap(String telefone) async {
    dev.log(telefone);
    var link = Uri.parse(
        "https://wa.me/55${telefone}?text=Ola%2C%20vejo%20que%20compartilhamos%20interesse%20em%20um%20imovel%20em%20comum%2C%20gostaria%20de%20conversar%3F");
    if (!await launchUrl(link)) {
      throw 'Could not launch $telefone';
    }
  }

  sendInvitation(BuildContext context, int contatoId) async {
    final response = await injectedImmobileController.sendInvitation(contatoId);
    if (response.statusCode == 201) {
      success(context, response.response);
    } else if (response.statusCode == 200) {
      success(context, response.response);
    }
    else {
      errorRegister(context, response.response);
    }
  }

  Future<String?> success(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Atenção!'),
            content: response != null
                ? Text(response)
                : Text(
                'Solititação enviada'),
            actions: [
              TextButton(
                onPressed: () =>
                {Navigator.pop(context, 'OK')},
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<String?> errorRegister(BuildContext context, String? response) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Atenção!'),
            content: response != null
                ? Text(response)
                : Text(
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
