import 'package:easy_home/modules/real_estate_list/real_estate_list.dart';
import 'package:easy_home/modules/real_estate_list/real_estate_list_binding.dart';
import 'package:get/get.dart';

import '../modules/Login/login_binding.dart';
import '../modules/Login/login_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.realEstateList,
        page: () => const RealEstateList(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: RealEstateListBinding()),
  ];
}
