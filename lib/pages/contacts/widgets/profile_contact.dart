import 'package:easy_home_app/models/contact_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/contacts/view_models/contacts_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

import '../../../menu_layout.dart';
import '../../Profile/widgets/profile_info_row.dart';
import '../../Profile/widgets/top_portion.dart';

class ContactsProfile extends StatefulWidget {
  final User user;

  const ContactsProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<ContactsProfile> createState() => _ContactsProfileState();
}

class _ContactsProfileState extends State<ContactsProfile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
            return Scaffold(
              backgroundColor: AppColors.pages,
              appBar: AppBar(
                backgroundColor: AppColors.background,
                title: const Text("Perfil do Contato"),
              ),
              drawer: MenuDashboardPage(),
              body: Column(
                children: [
                  Expanded(flex: 2, child: TopPortion(user: widget.user)),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.user.name.capitalize!,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            children: [
                              FloatingActionButton.extended(
                                onPressed: () async {
                                  var email = "mailto:" + widget.user.email;
                                  await launchUrl(Uri.parse(email));
                                },

                                elevation: 1,
                                label: const Text("Email"),
                                icon: const Icon(Icons.email),
                                backgroundColor: AppColors.yellow,
                              ),
                              const SizedBox(height: 16.0),
                              FloatingActionButton.extended(
                                onPressed: () async {
                                  var message = 'Mensagem Pronta';
                                  var recipient = '55${widget.user.cellPhone}';
                                  var url = 'https://api.whatsapp.com/send?phone=$recipient&text=$message';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Não foi possível enviar a mensagem';
                                  }
                                },
                                elevation: 1,
                                label: const Text("WhatsApp"),
                                icon: const Icon(Icons.chat_bubble_outline),
                                backgroundColor: AppColors.yellow,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
}
