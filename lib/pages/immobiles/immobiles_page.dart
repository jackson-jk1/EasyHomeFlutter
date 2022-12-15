import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/pages/immobiles/widgets/list_Immobiles.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImmobilesPage extends GetWidget<ImmobileViewModel> {

  const ImmobilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Lista de imóveis"),
      ),
      body: ImmobilesList(controller: controller)
    );
  }
}