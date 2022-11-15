import 'package:flutter/material.dart';
import '../../../data/model/Immobile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:developer' as dev;
import '../../real_estate_details/details_page.dart';

class RealEstate extends StatelessWidget {

  const RealEstate({Key? key}) : super(key: key);

  Future<List<Immobile>> _getImmobiles() async {
    http.Response response = await http.get(Uri.parse("https://b8e5-2804-7f4-378f-f04c-a44d-dc0c-9e5b-30ed.sa.ngrok.io/Immobile"));


    var dadosJson = json.decode(response.body);

    List<Immobile> immobiles = <Immobile>[];
    for (var immo in dadosJson) {
      Immobile i = Immobile(
          immo["_id"],
          immo["id"],
          immo["title"],
          immo["rooms"],
          immo["desc"],
          immo["price"],
          immo["address"],
          immo["images"],
          immo["map"]
      );
      immobiles.add(i);
    }
    return immobiles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Immobile>>(
        future: _getImmobiles(),
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
                List<Immobile>?lista = snapshot.data;
                if(lista != null) {
                  Immobile i = lista[index];
                  String title = i.title;

                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DetailsScreen(),
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
                                              orElse: () => 'images/imovel_exemplo.jpg'),
                                              width: 80,
                                              height: 80,
                                              fit:BoxFit.fill,
                                              errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                    'images/imovel_exemplo.jpg',
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
                                          "R\$:" + i.price,
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
                return ListTile(
                    title: Text("Sem imoveis no momento")
                );
              }
          );

        }
    );

  }
}
