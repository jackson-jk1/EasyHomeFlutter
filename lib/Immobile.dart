import 'dart:ffi';

class Immobile {
  String idMongo = "";
  String id = "";
  String title = "";
  String rooms = "";
  String desc = "";
  String price = "";
  String address = "";
  List<dynamic> images = [];
  String map = "";

  Immobile(this.idMongo, this.id, this.title, this.rooms, this.desc, this.price,
      this.address, this.images, this.map);
}