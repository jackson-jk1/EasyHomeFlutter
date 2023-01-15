
import 'package:easy_home_app/pages/Profile/edit_profile_page.dart';
import 'package:easy_home_app/pages/Profile/profile_view_page.dart';
import 'package:easy_home_app/pages/favorites/favorite_list.dart';
import 'package:easy_home_app/pages/immobiles/immobiles_page.dart';
import 'package:easy_home_app/pages/login/login_register_binding.dart';
import 'package:easy_home_app/pages/login/login_register_page.dart';
import 'package:easy_home_app/widgets/splash_screen.dart';
import 'package:get/get.dart';
import '../pages/Profile/profile_binding.dart';
import '../pages/Reset_password/reset_pass_binding.dart';
import '../pages/Reset_password/reset_pass_page.dart';
import '../pages/favorites/bidings/favorite_list_binding.dart';
import '../pages/immobiles/bidings/immobiles_list_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.login,
        page: () => LoginPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: LoginBinding(),
    ),
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 800),
    ),
    GetPage(
        name: AppRoutes.realEstateList,
        page: () => ImmobilesPage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 800),
        binding: ImmobilesBinding()
    ),
    GetPage(
        name: AppRoutes.favorite,
        page: () => FavoritePage(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 800),
        binding: FavoritesBinding(),
    ),
    GetPage(
        name: AppRoutes.profile,
        page: () => const ViewProfile(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: ProfileBinding()
    ),

    GetPage(
        name: AppRoutes.editProfile,
        page: () =>  EditProfile(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 500),
        binding: ProfileBinding()),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPassword(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: ResetPasswordBinding(),
    ),
  ];
}
