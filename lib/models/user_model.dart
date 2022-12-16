
class User {
  int id;
  String email;
  String name;
  String cellPhone;
  String image;

  User({required this.id, required this.email, required this.name, required this.cellPhone,
    required this.image});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cellPhone = json['cellPhone'],
        email = json['email'],
        image =  json['image'],
        id = json['id'];

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name, 'cellPhone': cellPhone,
    'image': image,};
}