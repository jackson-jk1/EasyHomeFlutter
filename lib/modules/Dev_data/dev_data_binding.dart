import 'package:easy_home/modules/Dev_data/dev_data_controller.dart';
import 'package:get/get.dart';

import '../../data/provider/api/http_client.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DevDataController>(() => DevDataController());
  }
}
