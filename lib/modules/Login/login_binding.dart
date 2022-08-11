import 'package:get/instance_manager.dart';

import '../../data/model/user_model.dart';
import '../../data/provider/api/http_client.dart';
import '../../data/repository/login_repository.dart';
import 'login_view_model.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => LoginViewModel(
            injectedLoginRepository:
            Get.put(LoginRepository(http: Get.find<HttpClient>())),
            injectedUserModel: Get.put(UserModel(id: 0, token: '', email: ''),
                permanent: true)),
        fenix: true);
  }
}