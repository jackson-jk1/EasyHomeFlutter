import 'package:get/instance_manager.dart';

import '../../data/model/auth_model.dart';
import '../../data/provider/api/http_client.dart';
import '../../data/repository/login_repository.dart';
import '../../data/repository/register_repository.dart';
import 'login_view_model.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => LoginViewModel(
            injectedLoginRepository:
            Get.put(LoginRepository(http: Get.find<HttpClient>())),
            injectedRegisterRepository:
            Get.put(RegisterRepository(Http: Get.find<HttpClient>())),
            injectedAuthModel: Get.put(AuthModel(token: ''),
                permanent: true)),
        fenix: true);
  }
}