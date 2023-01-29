import 'package:easy_home_app/pages/contacts/view_models/contacts_view_model.dart';
import 'package:easy_home_app/pages/contacts/widgets/list_Contacts.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../menu_layout.dart';

class ContactsPage extends GetWidget<ContactViewModel> {

  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pages,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Contato"),
      ),
      drawer: MenuDashboardPage(),
      body: ContactsList(controller: controller)
    );
  }
}