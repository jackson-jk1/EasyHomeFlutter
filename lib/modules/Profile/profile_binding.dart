import 'package:easy_home/data/provider/storage/storage_keys.dart';
import 'package:get/instance_manager.dart';

import '../../data/model/auth_model.dart';
import '../../data/provider/api/http_client.dart';
import '../../data/repository/user_repository.dart';
import 'profile_view_model.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => ProfileViewModel(
            injectedUserRepository:
            Get.put(UserRepository(Http: Get.find<HttpClient>()))),
        fenix: true);
  }
}