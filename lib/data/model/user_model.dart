import 'Immobile.dart';

class UserModel {
  int id;
  String email;
  String password;
  String name;
  String cellPhone;
  String image;
  List<Immobile>? userPreferences;

  UserModel({required this.id, required this.email, required this.password, required this.name, required this.cellPhone,
    required this.image, required this.userPreferences});

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cellPhone = json['cellPhone'],
        email = json['email'],
        password = json['password'],
        image = json['image'],
        userPreferences = json['userPreferences'],
        id = json['id'];

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'password': password, 'name': name, 'cellPhone': cellPhone,
    'image': image, 'userPreferences': userPreferences};
}