import 'package:easy_home_app/pages/notifications/view_models/notifications_view_model.dart';
import 'package:easy_home_app/pages/notifications/widgets/list_Notifications.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../menu_layout.dart';

class NotificationsPage extends GetWidget<NotificationViewModel> {

  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pages,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Lista de Notificações"),
      ),
      drawer: MenuDashboardPage(),
      body: NotificationsList(controller: controller)
    );
  }
}