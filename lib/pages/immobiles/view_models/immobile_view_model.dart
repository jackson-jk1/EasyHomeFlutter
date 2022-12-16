import 'package:easy_home_app/controllers/immobile_controller.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

class ImmobileViewModel extends GetxController {

   final ImmobileController injectedImmobileController;
   ImmobileViewModel({required this.injectedImmobileController});


   Future<List<Immobile>> getImmobiles (Filters filters) async {
       return await injectedImmobileController.getImmobiles(filters);
    }

   Future<List<Polo>> getPolos() async {
     return await injectedImmobileController.getPolos();
   }

   Future<List<User>> getinterested (int immId) async {
     return await injectedImmobileController.getinterested(immId);
   }


   Future<bool> checkList (int immId) async {
     return  await injectedImmobileController.checkList(immId);
   }

   void addPreference(int immId, BuildContext context, bool status) async{
     var response = status == true
          ? await injectedImmobileController.addFavorite(immId)
          : await injectedImmobileController.removeFavorite(immId);
      if(response != 200){
        errorRegister(context);
      }

   }

   void removePreference(int immId, BuildContext context) async{
     var response  = await injectedImmobileController.removeFavorite(immId);
     if(response != 200){
       errorRegister(context);
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