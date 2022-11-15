import 'package:easy_home/modules/Dev_data/dev_data_page.dart';
import 'package:easy_home/modules/Contact/contact_page.dart';
import 'package:easy_home/modules/Reset_password/reset_pass_binding.dart';
import 'package:easy_home/modules/Reset_password/reset_pass_page.dart';
import 'package:easy_home/modules/real_estate_list/real_estate_list.dart';
import 'package:easy_home/modules/real_estate_list/real_estate_list_binding.dart';
import 'package:get/get.dart';

import '../modules/Profile/edit_profile_page.dart';
import '../modules/Login/login_binding.dart';
import '../modules/Login/login_page.dart';

import '../modules/Dev_data/dev_data_binding.dart';
import '../modules/Dev_data/dev_data_page.dart';
import '../modules/Contact/contact_binding.dart';
import '../modules/Contact/contact_page.dart';
import '../modules/Manual/manual_page.dart';
import '../modules/real_estate_details/details_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.login,
        page: () => LoginPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.realEstateList,
        page: () => const RealEstateList(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: RealEstateListBinding()),
    GetPage(
        name: AppRoutes.devData,
        page: () => const DevDataPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: AppRoutes.contact,
        page: () => const ContactPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: AppRoutes.details,
        page: () => const DetailsScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: AppRoutes.manual,
        page: () => const ManualPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: AppRoutes.profile,
        page: () => const EditProfile(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: AppRoutes.resetPassword,
        page: () => const ResetPassword(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: ResetPasswordBinding(),
    ),
  ];
}
