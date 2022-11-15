import 'package:easy_home/data/repository/reset_pass_repository.dart';
import 'package:get/instance_manager.dart';

import '../../data/provider/api/http_client.dart';
import 'reset_pass_view_model.dart';


class ResetPasswordBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(
            () => ResetPasswordViewModel(
                injectedPasswordRepository: Get.put(ResetPasswordRepository(http: Get.find<HttpClient>()))
            ),
        fenix: true);
  }
}