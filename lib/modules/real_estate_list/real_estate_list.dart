import 'package:easy_home/modules/real_estate_list/widgets/real_estate.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:flutter/material.dart';

class RealEstateList extends StatelessWidget {
  const RealEstateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Lista de imóveis"),
      ),
      body: RealEstate(),
    );
  }
}
