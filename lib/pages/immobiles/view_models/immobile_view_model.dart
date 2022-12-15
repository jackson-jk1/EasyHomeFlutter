import 'package:easy_home_app/controllers/immobile_controller.dart';
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
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

   Future<bool> checkList (int immId) async {
     return  await injectedImmobileController.checkList(immId);
   }

}