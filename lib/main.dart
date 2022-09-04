import 'dart:io';

import 'package:easy_home/routes/app_pages.dart';
import 'package:easy_home/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/initial_binding.dart';


void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.full,
      initialBinding: InitialBinding(),
      title: 'EasyHome',
      initialRoute: AppRoutes.details,
      getPages: AppPages.pages,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}