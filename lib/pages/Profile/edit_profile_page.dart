import 'dart:io';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/Profile/profile_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:easy_home_app/widgets/build_button.dart';
import 'package:easy_home_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../menu_layout.dart';


class EditProfile extends GetWidget<ProfileViewModel> {
  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Editar Perfil",
      home: Scaffold(
      drawer: MenuDashboardPage(),
      appBar: AppBar(title: const Text("Editar Perfil"), backgroundColor: AppColors.background,),
      body: BuildPage(),
      ),
    );
  }
}

class BuildPage extends GetWidget<ProfileViewModel> {
  final HttpClient? Http = null;
   BuildPage({
    Key? key,
  }) : super(key: key);
  File? images = null;


  @override
  Widget build(BuildContext context) {

    Future<File?> getImage(ImageSource source) async {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return null;
      //TO convert Xfile into file
      this.images = File(image!.path);
      (context as Element).markNeedsBuild();

      return images;
    }
    return FutureBuilder<User>(
        future: controller.processProfile(),
        builder: (context, snapshot){
          User? user = snapshot.data;
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

            controller.emailController.text = controller.emailController.text.isEmpty == true ? user.email : controller.emailController.text;
            controller.nomeController.text = controller.nomeController.text.isEmpty == true ? user.name : controller.nomeController.text;
            controller.telefoneController.text =  controller.telefoneController.text.isEmpty == true ? user.cellPhone :  controller.telefoneController.text;
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
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          images != null ?
                          ClipOval(
                            child: Image.file(
                              images!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                               ),
                            )
                              : ProfileWidget(
                            imagePath: user.image,
                            onClicked: () async {},
                          ),
                          const SizedBox(height: 14),
                          buildButton(
                            title: 'Galeria',
                            icon: Icons.image_outlined,
                            onClicked: () => getImage(ImageSource.gallery),
                          ),
                          const SizedBox(height: 14),
                          buildButton(
                            title: 'Camera',
                            icon: Icons.camera_alt_outlined,
                            onClicked: () => getImage(ImageSource.camera),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            style: TextStyle(color: AppColors.white),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(labelText: "Email",
                              filled: true,
                              fillColor: Color.fromRGBO(33, 39, 74,1.0),
                              labelStyle: TextStyle(color: Colors.white),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(61, 59, 59,1.0), width: 0.5),
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
                            controller: controller.emailController,
                            validator: (email) => controller.validateEmail(email),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(

                            style: TextStyle(color: AppColors.white),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(labelText: 'Name',
                              filled: true, //<-- SEE HERE
                              fillColor: Color.fromRGBO(33, 39, 74,1.0),//<-- SEE HERE
                              labelStyle: TextStyle(color: Colors.white),
                              border:OutlineInputBorder(
                                borderSide: const BorderSide(color: Color.fromRGBO(33, 39, 74,1.0), width: 0.5),
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
                             validator: (nome) => controller.validateName(nome),
                             controller: controller.nomeController

                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(

                            style: TextStyle(color: AppColors.white),
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(labelText: "Telefone",
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
                            controller: controller.telefoneController,
                            validator: (cellphone) => controller.validateCellphone(cellphone),

                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(

                              onPressed: () => controller.validateForm(context, images),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.yellow,
                                  minimumSize: Size(Get.width, Get.height * 0.05)

                              ),
                              child:
                              Text("Salvar Mudanças"))
                        ],
                      ),),

                  ],
                ),
              ),
            ),
          );
          }
        }
    );

  }
}
