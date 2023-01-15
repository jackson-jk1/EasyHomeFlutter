
import 'package:easy_home_app/core/utils/constants.dart';

class User {
  int id;
  String email;
  String name;
  String password;
  String cellPhone;
  String image;

  User({required this.id, required this.email, required this.password, required this.name, required this.cellPhone,
    required this.image});

  User.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        cellPhone = json['CellPhone'],
        password = json['Password'] != '' ? json['Password'] : '',
        email = json['Email'],
        image =  Constants.apiUrl + "/Imagens/" + json['Image'],
        id = json['Id'];

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name, 'cellPhone': cellPhone,
    'image': image,};
}