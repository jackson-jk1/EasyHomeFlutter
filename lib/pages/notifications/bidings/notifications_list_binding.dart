import 'package:easy_home_app/controllers/notification_controller.dart';
import 'package:easy_home_app/pages/notifications/view_models/notifications_view_model.dart';
import 'package:easy_home_app/provider/api/http_client.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import 'package:get/get.dart';



class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
            () => NotificationViewModel(
              injectedNotificationController:
            Get.put(NotificationController(injectedHttp: Get.find<HttpClient>(), injectedStorage: new StorageKeys())),
            ));
  }
}
