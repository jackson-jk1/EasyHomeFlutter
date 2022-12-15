import 'package:easy_home_app/provider/api/http_client.dart';
import 'package:get/instance_manager.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HttpClient(), permanent: true);
  }
}
