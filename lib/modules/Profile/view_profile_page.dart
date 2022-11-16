import 'dart:io';

import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile_page.dart';
import 'package:easy_home/shared/widgets/build_button.dart';
import 'profile_view_model.dart';
import '../../data/repository/user_repository.dart';

import '../../menu_layout.dart';

class ViewProfile extends StatelessWidget {
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
  const BuildPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? images;

    Future pickImage(ImageSource source) async {
      try{
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;

        final imageTemporary = File(image.path);
        //return imageTemporary;
        //setState(() => images = imageTemporary);
      } on PlatformException catch(e){
        print('Falha na escolha da imagem: $e');
      }
    }
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
                    images != null ?
                    Image.file(
                      images!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                        :  Image.asset(
                      'images/no_user.jpg',
                      width: 150,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextField(
                      enabled: false,
                      style: TextStyle(color: AppColors.white),
                      decoration: const InputDecoration(labelText: 'E-mail',
                        filled: true,
                        fillColor: Color.fromRGBO(33, 39, 74,1.0),
                        labelStyle: TextStyle(color: Colors.white),
                        border:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),

                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                      //validator: (email) => controller.validateEmail(email),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      enabled: false,
                      style: TextStyle(color: AppColors.white),
                      decoration: const InputDecoration(labelText: 'Nome',
                        filled: true, //<-- SEE HERE
                        fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                        labelStyle: TextStyle(color: Colors.white),
                        border:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),

                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),),
                      // validator: (Nome) => controller.validateName(Nome),
                      // controller: controller.nomeController
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      enabled: false,
                      style: TextStyle(color: AppColors.white),
                      decoration: const InputDecoration(labelText: 'Telefone',
                        filled: true, //<-- SEE HERE
                        fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                        labelStyle: TextStyle(color: Colors.white),
                        border:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),

                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),

                      ),
                      //validator: (Telefone) => controller.validateCellphone(Telefone),

                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () => controller.processProfile(),//const EditProfile(),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(Get.width, Get.height * 0.05)),
                        child:
                        Text("Editar Perfil"))
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
}
