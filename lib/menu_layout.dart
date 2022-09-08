import 'package:easy_home/routes/app_routes.dart';
import 'package:easy_home/theme/AppColors.dart';
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
              'images/LOGO.png',
               width: 100,
               height: 100,
               )),
            Padding(
            padding: const EdgeInsets.only(left: 14, top: 5),
            child: Text(
                 'Aluno exemplo\n'+ 'Aluno@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 12),
               )),
             ],
           )
          ),
          ListTile(
            leading: Icon(Icons.house),
            title: Text('Imóveis',
                style: TextStyle(color: Colors.white)),
            onTap: () => { Get.offAllNamed(AppRoutes.realEstateList)},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Feedback',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.contact)},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Contato',
                style: TextStyle(color: Colors.white)),
            onTap: () => {Get.offAllNamed(AppRoutes.devData)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout',
                style: TextStyle(color: Colors.white)),
            onTap: () => { Get.offAllNamed(AppRoutes.login)},
          ),
        ],
      ),
    );
  }
}