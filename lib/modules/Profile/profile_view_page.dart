import 'dart:io';

import 'package:easy_home/modules/Profile/widgets/button_widget.dart';
import 'package:easy_home/modules/Profile/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/user_model.dart';
import 'profile_view_model.dart';
import '../../menu_layout.dart';
import 'package:easy_home/data/provider/api/http_client.dart';

class ViewProfile extends GetWidget<ProfileViewModel> {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perfil",
      home: Scaffold(
        drawer: MenuDashboardPage(),
        appBar: AppBar(title: const Text("Perfil"), backgroundColor: AppColors.background,),
        body: const BuildPage(),
      ),
    );
  }
}

class BuildPage extends GetWidget<ProfileViewModel> {
  final HttpClient? Http = null;
  const BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? images;
     return FutureBuilder<UserModel>(
      future: controller.processProfile(),
      builder: (context, snapshot){
      UserModel? user = snapshot.data;
      if(user == null){
      return Scaffold(
          appBar: AppBar(
            title: Text("Error"),
          ),
          body: Center(
          child: Text("${snapshot.error}"),
          ),
          );
        }
        else{
          return Scaffold(
          backgroundColor: AppColors.background,
          body:
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      children: [
                        const SizedBox(height: 24),
                        ProfileWidget(
                          //imagePath: 'https://b600-138-118-169-27.sa.ngrok.io/Imagens/' + user.image,
                          //imagePath: Uri.parse('${Http?.apiUrl()}/Imagens/' + user.image).toString(),
                          imagePath: 'https://1841-2804-7f4-378f-f04c-491d-940e-8e27-3137.sa.ngrok.io/Imagens/' + user.image,
                          onClicked: () async {},
                        ),
                        const SizedBox(height: 24),
                        buildName(user),
                        const SizedBox(height: 24),
                        Center(child: buildUpgradeButton(context)),
                        const SizedBox(height: 48),
                      ],
                    ),
                ],
              ),
            ),
          ),
         );
        }
      }
     );

    }
  Widget buildName(UserModel user) => Column(
    children: [
    Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        user.name,
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 24),
      )
    ),
      const SizedBox(height: 4),
    Padding(
    padding: EdgeInsets.all(1),
    child: Text(
          user.email,
          style: TextStyle(color: AppColors.white,fontSize:18),
        )
    ),
      const SizedBox(height: 4),
    Padding(
    padding: EdgeInsets.all(1),
    child: Text(
        user.cellPhone,
        style: TextStyle(color: AppColors.white,fontSize:18),
      )
    )
    ],
  );


  Widget buildUpgradeButton(context) => ButtonWidget(
    text: 'Editar Dados',
    onClicked: () => controller.editProfile(context),
  );
  /*Widget buildAbout(UserModel user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );*/

  }

