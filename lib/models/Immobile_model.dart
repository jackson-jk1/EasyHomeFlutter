import 'dart:convert';
import 'dart:ffi';

class Immobile {

  int id;
  String title;
  int rooms;
  String desc;
  double price;
  String address;
  List<dynamic> images = [];
  String map;
  Bool isActive;


  Immobile({required this.id, required this.title, required this.rooms,required this.desc, required this.price,
    required this.address, required this.images, required this.map, required this.isActive});

  Immobile.fromJson(Map<String, dynamic> json)
      :
        id = json["Id"],
        title = json["Title"],
        rooms = json["Rooms"],
        desc = json["Desc"],
        price = json["Price"],
        address = json["Address"],
        images = json["Imgs"],
        map = json["Map"],
        isActive = json["isActive"];

}