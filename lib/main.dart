//@dart=2.9
import 'dart:io';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import 'package:easy_home_app/routes/app_pages.dart';
import 'package:easy_home_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/initial_binding.dart';

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.full,
      initialBinding: InitialBinding(),
      title: 'EasyHome',
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      navigatorObservers: [NavigationObserver()],
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    _saveCurrentRoute(route);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    _saveCurrentRoute(previousRoute);
  }

  void _saveCurrentRoute(Route route) async {
    if(route.settings.name != null) {
      final sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString("LAST_NAVIGATED_DESTINATION", route.settings.name);
    }
  }
}