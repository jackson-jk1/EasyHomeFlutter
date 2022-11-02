import 'package:easy_home/modules/real_estate_list/widgets/real_estate.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/material.dart';

import '../../menu_layout.dart';

class RealEstateList extends StatelessWidget {
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
      body: RealEstate(),
    );
  }
}
