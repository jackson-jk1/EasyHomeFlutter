import 'package:easy_home_app/models/filters_model.dart';
import 'package:easy_home_app/models/polo_model.dart';
import 'package:easy_home_app/models/token_model.dart';
import 'package:easy_home_app/models/user_model.dart';
import 'package:easy_home_app/provider/storage/storage_keys.dart';
import '../models/Notification_model.dart';
import '../provider/api/http_client.dart';
import 'dart:convert';
import 'dart:developer' as dev;

class NotificationController {
  final HttpClient injectedHttp;
  final StorageKeys injectedStorage;

  NotificationController({required this.injectedHttp, required this.injectedStorage});

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

  Future<List<User>> getNotifications(int userId) async {
    String? retorno = await injectedStorage.readToken();
    final response = await injectedHttp.get(
        url: "${injectedHttp.apiUrl()}/v1/user/getByImm/${userId}",
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${retorno}'},
    );


    var tagObjsJson = response.body['data'] as List;
    List<User> users = tagObjsJson.map((u) => User.fromJson(u)).toList();
    return users;
  }



}