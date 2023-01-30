
import 'dart:core';

import 'package:easy_home_app/provider/api/http_client.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import 'package:easy_home_app/routes/app_routes.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

class MenuDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpClient injectedHttp = new HttpClient();
    final StorageKeys injectedStorage = new StorageKeys();

    Future<int> verifyNotification() async {
      String? retorno = await injectedStorage.readToken();
      final response = await injectedHttp.get(
          url: "${injectedHttp.apiUrl()}/v1/user/listNotification",
          header: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${retorno}'
          }
      );
      var tagObjsJson = response.body['data'].toString();
      dev.log(tagObjsJson);
      return tagObjsJson == "[]" ?  0 :  1;
    }
    return Drawer(
      backgroundColor: AppColors.menuBar,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
           margin: const EdgeInsets.only(top:40.0, bottom: 10),
           padding: const EdgeInsets.all(4),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
           Padding(
           padding: const EdgeInsets.all(2.0),
             child:Image.asset(
              'imagens/FlutterA.png',
               width: 100,
               height: 100,
               )),
             ],
           )
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text('Imóveis',
                style: TextStyle(color: Colors.white)),
            onTap: () => { Get.offAllNamed(AppRoutes.realEstateList)},
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Alterar Senha',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.editPassword)},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.profile)},
          ),
          ListTile(

            leading: const Icon(Icons.favorite),
            title: const Text('Favoritos',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.favorite)},
          ),
          FutureBuilder<int>(
            future: verifyNotification(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: snapshot.data == 0
                      ? const Icon(Icons.notifications)
                      : const Icon(Icons.notification_add, color: Color(0xdef59e16)),
                  title: snapshot.data == 0
                      ? const Text('Notificações',
                      style: TextStyle(color: Colors.white))
                      : const Text('Notificações',
                      style: TextStyle(color: Color(0xdef59e16))),
                  onTap: () => Get.offAllNamed(AppRoutes.notifications),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('Contacts',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.contacts)},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout',
                style: TextStyle(color: Colors.white)),
            onTap: () => { Get.offAllNamed(AppRoutes.login)},
          ),
        ],
      ),
    );
  }
}