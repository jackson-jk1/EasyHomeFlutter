class GenericResponse {
  String? response;
  int? statusCode;

  GenericResponse({required this.response, required this.statusCode});

  GenericResponse.fromJson(Map<String, dynamic> json)
      : response = json['Response'],
        statusCode = json['Statuscode'];

  Map<String, dynamic> toJson() => {'Response': response, 'Statuscode': statusCode};
}