
import 'package:easy_home_app/routes/app_routes.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MenuDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(Icons.verified_user),
            title: const Text('Feedback',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.contact)},
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