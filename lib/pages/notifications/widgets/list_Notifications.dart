import 'package:easy_home_app/models/notification_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/pages/notifications/view_models/notifications_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class NotificationsList extends StatefulWidget {
  final NotificationViewModel controller;

  const NotificationsList({Key? key, required this.controller}) : super(key: key);

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {

 // late Future<List<User>> getNotifications;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
          Expanded(
              child: FutureBuilder<List<User>>(
                  //future: getNotifications,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return ListTile(
                        title: Text(
                          'Sem notificações no momento',
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
                                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.yellow, width: 2),
                                        borderRadius: BorderRadius.circular(10),
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
                                          title: const Text(
                                            'Deseja adicionar" + u.name + "a lista de contatos?',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16
                                            ),
                                          ),
                                          trailing:
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                iconSize: 22,
                                                icon: Icon(Icons.check , color: Colors.lightGreen),
                                                onPressed: () async {},
                                              ),
                                              IconButton(
                                                iconSize: 22,
                                                icon: Icon(Icons.cancel , color: Colors.red),
                                                onPressed: () async {},
                                              ),
                                            ],
                                          )
                                      )
                                  );
                                }
                            ));
                    }
                    return ListTile(
                      title: Text(
                        'Sem notificações no momento',
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
