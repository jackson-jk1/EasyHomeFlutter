class NewUserModel {
  String email;
  String password;
  String name;
  String telefone;
  String image;

  NewUserModel({required this.email, required this.password, required this.name, required this.telefone, required this.image});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'telefone': telefone,
    'image': image
  };
}