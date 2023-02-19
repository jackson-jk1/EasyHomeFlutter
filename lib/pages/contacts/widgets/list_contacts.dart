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
                    return ListView.builder(
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
                                          var message = 'Mensagem Pronta';
                                          var recipient = '55${c.cellphone}';
                                          var url = 'https://api.whatsapp.com/send?phone=$recipient&text=$message';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Não foi possível enviar a mensagem';
                                          }
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
                                      InkWell(
                                        onTap: () async {
                                         await widget.controller.removeContact(c.contactId, context);
                                          setState(() {
                                            getContacts = widget.controller.listContacts();

                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.yellow.withOpacity(0.4), width:2,),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child:
                                          Icon(Icons.delete,color: AppColors.yellow,),
                                        ),
                                      )
                                    ],
                                  )

                              )
                          );
                        }
                    );
                }
              }
              return
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white24, width: 2)),
                  ),
                child: const ListTile(
                title: Text(
                  'Você não possui contatos',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              )
            );
          }
        ),
      ),
    ],
  );
}
