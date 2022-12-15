import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/token_model.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import '../models/Immobile_model.dart';
import '../provider/api/http_client.dart';
import 'dart:convert';
import 'dart:developer' as dev;

class ImmobileController {
  final HttpClient injectedHttp;
  final StorageKeys injectedStorage;

  ImmobileController({required this.injectedHttp, required this.injectedStorage});

  Future<List<Immobile>> getImmobiles(Filters filters) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.post(
         url: "${injectedHttp.apiUrl()}/v1/immobiles",
         header: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${retorno}'},
         body: filters.toJson()
      );


    var tagObjsJson = response.body['data']  as List;

    List<Immobile> immobiles = tagObjsJson.map((imm) => Immobile.fromJson(imm)).toList();
    return immobiles;
  }

  Future<List<Polo>> getPolos() async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.get(
        url: "${injectedHttp.apiUrl()}/v1/polo",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'},
    );

    var tagObjsJson = response.body['data']  as List;
    List<Polo> polos = tagObjsJson.map((imm) => Polo.fromJson(imm)).toList();
    return polos;
  }

  Future<bool> checkList (int immId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.get(
        url: "${injectedHttp.apiUrl()}/v1/user/preference/${immId}",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'},
    );

    var tagObjsJson = response.body['data'];
    return tagObjsJson;
  }

}