import 'package:flutter/material.dart';
import '../../../data/model/Immobile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:developer' as dev;
class RealEstate extends StatelessWidget {

  const RealEstate({Key? key}) : super(key: key);

  Future<List<Immobile>> _getImmobiles() async {
    http.Response response = await http.get(Uri.parse("https://18d7-2804-14c-87b9-b60d-5d4a-7d20-c192-bae3.sa.ngrok.io/Immobile"));

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

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 8, color: Colors.black12),
                              )),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          i.images.firstWhere((element) => element.toString() != null,
                                              orElse: () => 'images/imovel_exemplo.jpg'),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                    'images/imovel_exemplo.jpg',
                                                    fit: BoxFit.fitWidth);
                                          },
                                        )
                                      ],
                                    )),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
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
