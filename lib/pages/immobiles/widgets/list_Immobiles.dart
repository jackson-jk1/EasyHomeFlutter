
import 'package:easy_home_app/models/Immobile_model.dart';
import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/pages/immobiles/details_page.dart';
import 'package:easy_home_app/pages/immobiles/view_models/immobile_view_model.dart';
import 'package:easy_home_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;


class ImmobilesList extends StatefulWidget {
  final ImmobileViewModel controller;
  const ImmobilesList({Key? key, required this.controller}) : super(key: key);

  @override
  State<ImmobilesList> createState() => _ImmobilesListState();
}

class _ImmobilesListState extends State<ImmobilesList> {
  final dropvalue = new ValueNotifier("");
  late Future<List<Immobile>> getImmobiles;
  late Polo polo;
  Filters filters = new Filters(page: 1, polo: "", valueMax: 0, rooms: 0);
  late Future<List<Polo>> getPolos;
  static const IconData keyboard_control_outlined = IconData(0xeea7, fontFamily: 'MaterialIcons');
  int listTam = 1;

  @override
  void initState() {
    getImmobiles = widget.controller.getImmobiles(filters);
    getPolos = widget.controller.getPolos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

          return WillPopScope(
              onWillPop: () async {
            return false;
          },
          child: Column (
            children: [
             Row(children: <Widget>[
              Expanded(
              child: Padding(
                 padding: const EdgeInsets.fromLTRB(10,10,10,10),
                 child: ValueListenableBuilder(
                 valueListenable: dropvalue, builder: (BuildContext context,String value, _){
                 return Container(
                  height: 35,
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.yellow),
                  color: AppColors.secondary, borderRadius: BorderRadius.circular(10)),
                  child:
                    FutureBuilder<List<Polo>>(
                    future: getPolos,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("Error"),
                          ),
                          body: Center(
                            child: Text("${snapshot.error}"),
                          ),
                        );
                      }
                      List<Polo> polos = snapshot.data ?? <Polo>[];
                      return DropdownButton(
                        dropdownColor: AppColors.yellow,
                        isExpanded: true,
                        menuMaxHeight: 200,
                        hint: Text(
                            "Filtrar por Polos",
                            style: TextStyle(color: AppColors.white)),
                        value: (value.isEmpty) ? null : value,
                        onChanged: (escolha) =>
                        {
                          dropvalue.value = escolha.toString(),
                          setState(() {
                            filters.polo = escolha.toString();
                            getImmobiles = widget.controller.getImmobiles(filters);
                          })
                        },
                        items: polos.map((polo) {
                          return DropdownMenuItem<String>(
                            value: polo.name,
                            child: Text(
                              polo.name,
                              style: TextStyle(color: AppColors.white),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.yellow,

                        ),
                        iconSize: 42,
                        underline: SizedBox(),
                      );
                    }
                  )
                );
               }
              )
             )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    primary: AppColors.yellow
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(keyboard_control_outlined)
                  ],
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 350,
                        color: AppColors.yellow,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                             StatefulBuilder(builder: (context, setStateSB){
                               return
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(
                                   "Valor até R\$:" + filters.valueMax.round().toString(),
                                   style: TextStyle(color: AppColors.white, fontSize: 25),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.fromLTRB(80,0,80,80),
                                     child: Center(
                                       child: Slider(
                                         value: filters.valueMax,
                                         max: 2000,
                                         label: filters.valueMax.round().toString(),
                                         onChanged: (double value) {
                                           setStateSB(() {
                                             filters.valueMax = value;
                                           });
                                         },
                                       ),
                                     ),
                                   ),
                                   Text(
                                     "Nº de quartos: " + filters.rooms.toString(),
                                     style: TextStyle(color: AppColors.white, fontSize: 25),
                                   ),
                                   Container(
                                     padding: const EdgeInsets.fromLTRB(80,0,80,80),
                                     child: Center(
                                       child: Slider(
                                         value: double.parse(filters.rooms.toString()),
                                         max: 5,
                                         divisions: 5,
                                         label: filters.rooms.round().toString(),
                                         onChanged: (double value) {
                                           setStateSB(() {
                                             filters.rooms = value.round();
                                           });
                                         },
                                       ),
                                     ),
                                   )
                                 ],
                               );
                             }),

                            ],
                          ),
                        ),
                      );
                    },
                  ).whenComplete(() {
                    super.setState(() {
                      getImmobiles = widget.controller.getImmobiles(filters);
                    });
                  });
                },
              ))
             ]),
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
                                    builder: (_) =>  DetailsScreen(imm: i, controller: widget.controller),
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
                                                    Text(
                                                      "R\$:" + i.price.toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(color: Colors.white),
                                                    )
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
                          return Stack(
                            children: <Widget>[
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                              Center(
                                child: Text("Loading...", style: TextStyle(color: Colors.white)),
                              ),
                            ],
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
                        getImmobiles = widget.controller.getImmobiles(filters);
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
                      getImmobiles = widget.controller.getImmobiles(filters);
                    });
                },
                child: Text('Next'),
                ),
               ],
              ),
         ]
        ));
     }
  }
