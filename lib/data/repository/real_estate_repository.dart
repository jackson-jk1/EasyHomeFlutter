import '../model/polo_model.dart';
import '../provider/api/http_client.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class RealEstateRepository {
  final HttpClient Http;
  //final HttpClient Http;

  RealEstateRepository({required this.Http});

  Future<bool> scanQrCode(String qrCode) async {
    try {
      final response = await Http.post(
          url: "${Http.apiUrl()}/users/authenticate",
          header: {'Content-Type': 'application/json'},
          body: {"qrcode": qrCode});
      if (response.statusCodeIsOk) return true;
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PoloModel>> getPolos() async {
    try {
      /*final response = await Http.get(
          url: "${Http.apiUrl()}/v1/polo",
          header: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });*/
      http.Response response = await http.get(
          Uri.parse("${Http.apiUrl()}/v1/polo"));

      if(response.statusCode == 200){
        var dadosJson = json.decode(response.body);

        List<PoloModel> polos = <PoloModel>[];
        for (var polo in dadosJson) {
          PoloModel i = PoloModel(
              polo["id"],
              polo["name"]
          );
          polos.add(i);
        }
        return polos;
      } else {
      throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }
}
