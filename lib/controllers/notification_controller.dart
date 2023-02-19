import 'dart:convert';
import 'dart:io';

import 'package:easy_home_app/models/generic_response_model.dart';
import 'package:easy_home_app/models/notification_model.dart';
import 'package:easy_home_app/models/token_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import '../models/contact_model.dart';
import '../provider/api/http_client.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class NotificationController {
  final HttpClient injectedHttp;
  final StorageKeys injectedStorage;

  NotificationController({required this.injectedHttp, required this.injectedStorage});

  Future<List<Notify>> getNotifications() async{
      String? retorno = await injectedStorage.readToken();
      final response = await injectedHttp.get(
          url: "${injectedHttp.apiUrl()}/v1/notification/listNotification",
      header: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${retorno}'
       }
      );
      var tagObjsJson = response.body['data']  as List;
      dev.log(response.body['data'].toString());

      List<Notify> notifications = tagObjsJson.map((not) => Notify.fromJson(not)).toList();
      return notifications;
  }

  void readNotifications() async {
    String? retorno = await injectedStorage.readToken();
    await injectedHttp.put(
        url: "${injectedHttp.apiUrl()}/v1/notification/readNotification",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'
        },
      body: {}
    );
  }

  Future<GenericResponse> addContact(int contatoId, int notId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.post(
        url: "${injectedHttp.apiUrl()}/v1/user/addContact/${contatoId}/${notId}",
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

  recuseInvitation(int contatoId, int notId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.post(
        url: "${injectedHttp.apiUrl()}/v1/user/recuseInvitation/${contatoId}/${notId}",
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

   Future<List<Contact>>  listContacts() async{
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.get(
      url: "${injectedHttp.apiUrl()}/v1/user/listContacts",
      header: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${retorno}'},
    );

    var tagObjsJson = response.body['data'] as List;

    List<Contact> contacts = tagObjsJson.map((c) => Contact.fromJson(c)).toList();
    return contacts;
  }

}


