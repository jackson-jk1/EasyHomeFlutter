
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/pages/immobiles/details_page.dart';
import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/routes/app_routes.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

import '../details_page.dart';
import '../view_models/favorite_view_model.dart';


class FavoriteList extends StatefulWidget {
  final FavoriteViewModel controller;
  const FavoriteList({Key? key, required this.controller}) : super(key: key);

  @override
  State<FavoriteList> createState() => _ImmobilesListState();
}

class _ImmobilesListState extends State<FavoriteList> {
  final dropvalue = new ValueNotifier("");
  late Future<List<Immobile>> getImmobiles;
  late Polo polo;
  Filters filters = new Filters(page: 1, polo: "", valueMax: 0, rooms: 0);
  late Future<List<Polo>> getPolos;
  static const IconData keyboard_control_outlined = IconData(0xeea7, fontFamily: 'MaterialIcons');
  int listTam = 1;

  @override
  void initState() {
    getImmobiles = widget.controller.getFavorites(filters);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

          return
          Column (
            children: [
              Expanded(
              child: FutureBuilder<List<Immobile>>(
                  future: getImmobiles,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Scaffold(
                        appBar: AppBar(
                          title: Text("Error"),
                        ),
                        body: Center(
                          child: Text("${snapshot.error}"),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index){
                          if(snapshot.data != null) {
                            List<Immobile> lista = snapshot.data!;
                            listTam = lista.length;
                            Immobile i = lista[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>  DetailsFavoriteScreen(imm: i, controller: widget.controller),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 8, color: Colors.black12),
                                          )),
                                      margin: const EdgeInsets.symmetric(horizontal: 2),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child:Image.network(
                                                          i.images.firstWhere((element) => element.toString() != null,
                                                              orElse: () => 'imagens/sem_imagem.png'),
                                                          width: 80,
                                                          height: 80,
                                                          fit:BoxFit.fill,
                                                          errorBuilder:
                                                              (context, error, stackTrace) {
                                                            return Image.asset(
                                                              'imagens/sem_imagem.png',
                                                              width: 80,
                                                              height: 80,
                                                              fit:BoxFit.fill,

                                                            );
                                                          },
                                                        )
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      i.title.trimLeft(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "R\$:" + i.price.toString(),
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () async {
                                                            await widget.controller.removePreference(i.id, context);
                                                            setState(() {
                                                              getImmobiles = widget.controller.getFavorites(filters);

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
                                                        ),

                                                      ],
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return ListTile(
                              title: Text("Sem imoveis no momento")
                          );
                        }
                    );

                  }
              )
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.yellow,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if(filters.page == 1){
                        return;
                      }
                      setState(() {

                        filters.page--;
                        dev.log(filters.page.toString());
                        getImmobiles = widget.controller.getFavorites(filters);
                      });
                    },
                    child: Text('Prev'),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.yellow,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                onPressed: () {
                    if(listTam < 10){
                      return;
                    }
                    setState(() {
                      filters.page++;
                      dev.log(filters.page.toString());
                      getImmobiles = widget.controller.getFavorites(filters);
                    });
                },
                child: Text('Next'),
                ),
               ],
              ),

         ]
        );
     }
  }
