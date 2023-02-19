import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:easy_home_app/provider/api/http_client.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import 'package:get/instance_manager.dart';

import 'terms_view_model.dart';


class ResetPasswordBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(
            () => TermsViewModel(),
        fenix: true);
  }
}