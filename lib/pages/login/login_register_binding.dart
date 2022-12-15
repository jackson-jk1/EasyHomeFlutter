
import 'package:easy_home_app/controllers/user_controller.dart';
import 'package:easy_home_app/pages/login/login_register_view_model.dart';
import 'package:easy_home_app/provider/api/http_client.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import 'package:get/get.dart';





class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => LoginViewModel(
            injectedLoginRegisterController:
            Get.put(UserController(injectedHttp: Get.find<HttpClient>(), injectedStorage: new StorageKeys())),
            ),
        fenix: true);
  }
}