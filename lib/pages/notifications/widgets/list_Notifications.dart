import 'package:easy_home_app/models/notification_model.dart';
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

  late Future<List<Notify>> getNotifications;
  @override
  void initState() {
    super.initState();
    getNotifications = widget.controller.getNotifications();

  }
  @override
  void dispose() {
    super.dispose();
    widget.controller.readNotifications();
  }

  @override
  Widget build(BuildContext context) =>
      Column(children: [
        Expanded(
          child: FutureBuilder<List<Notify>>(
              future: getNotifications,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ListTile(
                    title: Text(
                      'Sem notificações no momento',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                }
                if (snapshot.data?.isEmpty == false) {
                  dev.log(snapshot.data.toString());
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      List<Notify> lista = snapshot.data!;
                      Notify n = lista[index];
                      if(n.status == 0){
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.yellow, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                "https://img.clasf.com.br/2020/01/09/Vendas-Casa-Campo-Largo-PR-20200109153543.8340310015.jpg",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              "Deseja adicionar " + n.name + " a lista de contatos?",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            trailing:Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await widget.controller.addContact(context, n.userId, n.id);
                                      setState(() {
                                        getNotifications = widget.controller.getNotifications();

                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child:
                                      Icon(Icons.check,color: Colors.green),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await widget.controller.recuseInvitation(context, n.userId, n.id);
                                      setState(() {
                                        getNotifications = widget.controller.getNotifications();

                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child:
                                      Icon(Icons.cancel,color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        );
                      }
                      if(n.status == 1 && !n.read) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.yellow,
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                "https://img.clasf.com.br/2020/01/09/Vendas-Casa-Campo-Largo-PR-20200109153543.8340310015.jpg",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title:Text(
                              n.name + " aceitou seu pedido de amizade",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      }
                      if(n.status == 2 && !n.read) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.yellow,
                                width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                "https://img.clasf.com.br/2020/01/09/Vendas-Casa-Campo-Largo-PR-20200109153543.8340310015.jpg",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title:Text(
                              n.name + " recusou seu pedido de amizade",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      }
                      return Container(
                        child: ListTile(
                          title: Text(
                            'Sem notificações no momento',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
              ),
           ),
      ]
    );
}
