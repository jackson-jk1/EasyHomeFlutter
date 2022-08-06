import 'package:easy_home/modules/real_estate_list/real_estate_list.dart';
import 'package:easy_home/modules/real_estate_list/real_estate_list_binding.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.realEstateList,
        page: () => const RealEstateList(),
        binding: RealEstateListBinding()),
  ];
}
