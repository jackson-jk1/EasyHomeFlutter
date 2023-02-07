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

import '../../contacts/widgets/profile_contact.dart';

class FavoriteViewModel extends GetxController {

   final ImmobileController injectedImmobileController;
   FavoriteViewModel({required this.injectedImmobileController});


   Future<List<Immobile>> getFavorites (Filters filters) async {
       return await injectedImmobileController.getFavorites(filters);
    }
   removePreference(int immId, BuildContext context) async {
     var response  = await injectedImmobileController.removeFavorite(immId);
     if(response != 200){
       errorRegister(context, "Erro interno tente novamente mais tarde");
     }
   }

   Future<List<User>> getinterested (int immId) async {
     String? retorno = await injectedImmobileController.injectedStorage.readToken();
     final response = await injectedImmobileController.injectedHttp.get(
       url: "${injectedImmobileController.injectedHttp.apiUrl()}/v1/user/getByImm/${immId}",
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
     return  await injectedImmobileController.checkList(immId);
   }
   sendInvitation(BuildContext context, int contatoId) async {
     var verify = await injectedImmobileController.getContact(contatoId);
     if(verify != null){
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => ContactsProfile(
             user: verify,
           ),
         ),
       );
       return;
     }
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
   Future<void> goZap (String telefone) async {
      telefone = "55" + telefone;
      var message = "Olá, vi que você possui interesse em alugar esse imovel gostaria de conversar sobre?";
      var url = Uri.parse("whatsapp://send?phone=$telefone&text=$message");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Não foi possível abrir o WhatsApp';
      }
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