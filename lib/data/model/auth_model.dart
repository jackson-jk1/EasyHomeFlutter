class AuthModel {
  String token;

  AuthModel({required this.token});

  AuthModel.fromJson(Map<String, dynamic> json)
      : token = json['Token'];

  Map<String, dynamic> toJson() => {'Token': token};
}