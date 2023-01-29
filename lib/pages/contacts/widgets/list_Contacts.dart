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

 // late Future<List<User>> getContacts;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
          Expanded(
              child: FutureBuilder<List<User>>(
                  //future: getContacts,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return const ListTile(
                        title: Text(
                          'Você não possui contatos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20

                          ),
                        ),
                      );
                    }
                    if(snapshot.data?.isEmpty == false){
                      dev.log(snapshot.data.toString());
                      return
                        Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index){
                                  List<User> lista = snapshot.data!;
                                  User u = lista[index];
                                  dev.log(u.image);
                                  return Container(
                                      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.white24, width: 2)),
                                      ),
                                      child: ListTile(
                                          leading: ClipOval(
                                            child: Image.network(
                                              u.image,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Text(
                                            u.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20

                                            ),
                                          ),
                                          trailing:
                                          IconButton(
                                            iconSize: 22,
                                            icon: Icon(Icons.chat_bubble_outline , color: AppColors.white),
                                            onPressed: () async {
                                              var contact = "+55" + u.cellPhone;
                                              var androidUrl = "whatsapp://send?phone=$contact";
                                              await launchUrl(Uri.parse(androidUrl));
                                            },
                                          )
                                      )
                                  );
                                }
                            ));
                    }
                    return const ListTile(
                      title: Text(
                        'Você não possui contatos',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20

                        ),
                      ),
                    );

                  }
              ),),

        ]);
}
