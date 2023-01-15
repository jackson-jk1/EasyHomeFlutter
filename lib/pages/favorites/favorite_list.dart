import 'package:easy_home_app/pages/favorites/view_models/favorite_view_model.dart';
import 'package:easy_home_app/pages/favorites/widgets/list_favorite_Immobiles.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../menu_layout.dart';

class FavoritePage extends GetWidget<FavoriteViewModel> {

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pages,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Favoritos"),
      ),
      drawer: MenuDashboardPage(),
      body: WillPopScope(
        onWillPop: () async {
      return false;
      },
       child: FavoriteList(controller: controller)
      )
    );
  }
}