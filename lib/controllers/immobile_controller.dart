import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import '../models/Immobile_model.dart';
import '../models/generic_response_model.dart';
import '../provider/api/http_client.dart';
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
  Future<int> addFavorite (int immId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.post(
      url: "${injectedHttp.apiUrl()}/v1/user/addPreference/${immId}",
      header: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${retorno}'},
         body: {}
    );

    var tagObjsJson = response.body['data']['Statuscode'];
    dev.log(tagObjsJson.toString());
    return tagObjsJson;
  }

  Future<int> removeFavorite (int immId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.delete(
      url: "${injectedHttp.apiUrl()}/v1/user/removePreference/${immId}",
      header: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${retorno}'},
         body: {}
    );

    var tagObjsJson = response.body['data']['Statuscode'];
    dev.log(tagObjsJson.toString());
    return tagObjsJson;
  }

  Future<List<User>> getinterested(int immId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.get(
        url: "${injectedHttp.apiUrl()}/v1/user/getByImm/${immId}",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'},
    );


    var tagObjsJson = response.body['data'] as List;
    List<User> users = tagObjsJson.map((u) => User.fromJson(u)).toList();
    return users;
  }

  Future<List<Immobile>> getFavorites(Filters filters) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.post(
        url: "${injectedHttp.apiUrl()}/v1/immobiles/getByUser",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'},
        body: filters.toJson()
    );


    var tagObjsJson = response.body['data']  as List;
    dev.log(response.body['data'].toString());
    List<Immobile> immobiles = tagObjsJson.map((imm) => Immobile.fromJson(imm)).toList();
    return immobiles;
  }

  Future<GenericResponse> sendInvitation(int contatoId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.post(
        url: "${injectedHttp.apiUrl()}/v1/user/sendInvitation/${contatoId}",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'
        },
        body: {}
    );
    var tagObjsJson = response.body['data'];
    dev.log(response.body['data'].toString());
    return GenericResponse.fromJson(tagObjsJson);
  }

}