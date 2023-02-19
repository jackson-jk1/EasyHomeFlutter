import 'dart:io';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/Profile/widgets/profile_info_row.dart';
import 'package:easy_home_app/pages/Profile/widgets/top_portion.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/profile_widget.dart';
import 'profile_view_model.dart';
import '../../menu_layout.dart';


class ViewProfile extends GetWidget<ProfileViewModel> {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Perfil",
      home: Scaffold(
        drawer: MenuDashboardPage(),
        appBar: AppBar(title: const Text("Perfil"), backgroundColor: AppColors.background,),
        body: WillPopScope(
          onWillPop: () async {
        return false;
        },
        child: const BuildPage()),
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
     return FutureBuilder<User>(
      future: controller.processProfile(),
      builder: (context, snapshot){
      User? user = snapshot.data;
      if(user == null){


      return Scaffold(
            backgroundColor: AppColors.pages
          );
        }
        else{
          return Scaffold(
            backgroundColor: AppColors.pages,
            body: Column(
              children: [
                Expanded(flex: 2, child: TopPortion(user: user)),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          user.name.capitalize!,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {
                                controller.editProfile(context);
                              },
                              heroTag: 'Editar',
                              elevation: 1,
                              label: const Text("Editar"),
                              icon: const Icon(Icons.edit),
                              backgroundColor: AppColors.yellow,
                            ),
                            const SizedBox(width: 16.0),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ProfileInfoRow(user: user)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
     );
    }
  }


