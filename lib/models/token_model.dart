class TokenModel {
  String token;

  TokenModel({required this.token});

  TokenModel.fromJson(Map<String, dynamic> json)
      : token = json['Token'];

  Map<String, dynamic> toJson() => {'Token': token};
}