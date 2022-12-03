import 'package:easy_home/data/model/polo_model.dart';
import 'package:easy_home/modules/real_estate_list/real_estate_view_model.dart';
import 'package:easy_home/modules/real_estate_list/widgets/dropdown_button.dart';
import 'package:easy_home/modules/real_estate_list/widgets/real_estate.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../menu_layout.dart';

class RealEstateList extends GetWidget<RealEstateViewModel> {
  const RealEstateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: MenuDashboardPage(),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Lista de imóveis"),
      ),
      body: Column(
       children: [
         DropdownButtonList(),
         //RealEstate(),
       ],
      )
    );
  }
}