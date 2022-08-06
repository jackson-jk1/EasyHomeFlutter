import 'package:get/instance_manager.dart';

import '../data/provider/api/http_client.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HttpClient(), permanent: true);
  }
}
