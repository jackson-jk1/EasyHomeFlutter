import 'package:easy_home_app/controllers/notification_controller.dart';
import 'package:easy_home_app/models/notification_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

class NotificationViewModel extends GetxController {

   final NotificationController injectedNotificationController;
   NotificationViewModel({required this.injectedNotificationController});



   Future<List<User>> getNotifications (int userId) async {
     String? retorno = await injectedNotificationController.injectedStorage.readToken();
     final response = await injectedNotificationController.injectedHttp.get(
       url: "${injectedNotificationController.injectedHttp.apiUrl()}/v1/user/getByImm/${userId}",
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


   Future<bool> checkList (int immId) async {
     return  await injectedNotificationController.checkList(immId);
   }

   Future<void> goZap (String telefone) async {
      dev.log(telefone);
     var link =  Uri.parse("https://wa.me/55${telefone}?text=Ola%2C%20vejo%20que%20compartilhamos%20interesse%20em%20um%20imovel%20em%20comum%2C%20gostaria%20de%20conversar%3F");
     if (!await launchUrl(link)) {
       throw 'Could not launch $telefone';
     }
   }
}

@override
Future<String?> errorRegister(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Atenção!'),
      content: Text('Erro interno, por favor tente novamente mais tarde'),
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