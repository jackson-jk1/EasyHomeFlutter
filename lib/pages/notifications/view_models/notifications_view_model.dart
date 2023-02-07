import 'package:easy_home_app/controllers/user_controller.dart';
import '../../../controllers/notification_controller.dart';
import '../../../models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

class NotificationViewModel extends GetxController {

   final NotificationController injectedController;
   NotificationViewModel({required this.injectedController});



   Future<List<Notify>> getNotifications () async {
     return await injectedController.getNotifications();
   }


  void readNotifications() {
      injectedController.readNotifications();
  }

   addContact(BuildContext context, int contatoId, int notId) async {
     final response = await injectedController.addContact(contatoId,notId);
     if (response.statusCode == 201) {
       success(context, response.response);
     } else if (response.statusCode == 200) {
       success(context, response.response);
     }
     else {
       errorRegister(context, response.response);
     }
   }

   recuseInvitation(BuildContext context, int userId, int id) async{
     final response = await injectedController.recuseInvitation(userId,id);
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
              onPressed: () {
              Navigator.pop(context, 'OK');
              },
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