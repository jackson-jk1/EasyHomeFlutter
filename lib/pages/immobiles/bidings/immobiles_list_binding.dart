import 'package:easy_home_app/controllers/immobile_controller.dart';
import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/provider/api/http_client.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import 'package:get/get.dart';



class ImmobilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => ImmobileViewModel(
              injectedImmobileController:
            Get.put(ImmobileController(injectedHttp: Get.find<HttpClient>(), injectedStorage: new StorageKeys())),
            ));
  }
}
