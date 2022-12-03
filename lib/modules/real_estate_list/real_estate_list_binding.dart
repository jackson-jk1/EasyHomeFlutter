import 'package:easy_home/data/repository/real_estate_repository.dart';
import 'package:easy_home/modules/real_estate_list/real_estate_list_controller.dart';
import 'package:get/get.dart';

import '../../data/provider/api/http_client.dart';

class RealEstateListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => RealEstateListController(
            injectedRealEstateRepository: 
            Get.put(RealEstateRepository(Http: Get.find<HttpClient>())),
            ));
  }
}
