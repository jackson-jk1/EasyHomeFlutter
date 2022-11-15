class GenericResponseModel {
  String? response;
  int? statusCode;

  GenericResponseModel({required this.response, required this.statusCode});

  GenericResponseModel.fromJson(Map<String, dynamic> json)
      : response = json['Response'],
        statusCode = json['Statuscode'];

  Map<String, dynamic> toJson() => {'Response': response, 'Statuscode': statusCode};
}