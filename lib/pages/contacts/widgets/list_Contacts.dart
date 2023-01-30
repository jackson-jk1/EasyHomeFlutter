import 'package:easy_home_app/models/contact_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/contacts/view_models/contacts_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;

class ContactsList extends StatefulWidget {
  final ContactViewModel controller;

  const ContactsList({Key? key, required this.controller}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {

  late Future<List<Contact>> getContacts;
  @override
  void initState() {
    getContacts = widget.controller.listContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: FutureBuilder<List<Contact>>(
            future: getContacts,
            builder: (context, snapshot){
              if(snapshot.hasData){
                List<Contact>? lista = snapshot.data;
                if(snapshot.data?.isEmpty == false){
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: lista!.length,
                        itemBuilder: (context, index){
                          Contact c = lista[index];
                          return Container(
                              margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.white24, width: 2)),
                              ),
                              child: ListTile(
                                  leading: ClipOval(
                                    child: Image.network(
                                      c.image,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    c.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        iconSize: 22,
                                        icon: Icon(Icons.chat_bubble_outline , color: AppColors.yellow),
                                        onPressed: () async {
                                          var contact = "+55" + c.cellphone;
                                          var androidUrl = "whatsapp://send?phone=$contact";
                                          await launchUrl(Uri.parse(androidUrl));
                                        },
                                      ),
                                      IconButton(
                                        iconSize: 22,
                                        icon: Icon(Icons.email, color: AppColors.yellow),
                                        onPressed: () async {
                                          var email = "mailto:" + c.email;
                                          await launchUrl(Uri.parse(email));
                                        },
                                      ),
                                    ],
                                  )

                              )
                          );
                        }
                    ),
                  );
                }
              }
              return ListTile(
                title: Text(
                  'Você não possui contatos',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              );
            }
        ),
      ),
    ],
  );
}
