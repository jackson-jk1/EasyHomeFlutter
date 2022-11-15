import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../data/model/new_user_model.dart';
import '../../data/provider/api/http_client.dart';


class Controller extends GetxController {
  final HttpClient Http;
  Controller(this.Http);

  Future<bool> uploadImage(File? file, NewUserModel user) async {
    var request =
    http.MultipartRequest('POST', Uri.parse('${Http.apiUrl()}/v1/user'));

    request.fields['Name'] = user.name.toString();
    request.fields['CellPhone'] = user.telefone.toString();
    request.fields['Email'] = user.email.toString();
    request.fields['Password'] = user.password.toString();

    request.files.add(http.MultipartFile.fromBytes('Image', File(file!.path).readAsBytesSync(),filename: file!.path.split('/').last));
    var res = await request.send();
    var resBody = await http.Response.fromStream(res);
    //final responseData = jsonDecode(resBody.body);
    //log(responseData.toString());

    if (res.statusCode == 201) {
      log('Retornou 201');
      return true;
    } else if (res.statusCode == 200) {
      log('Retornou 200');
      return true;
    }
    else{
      log('erro api');
      return false;
    }
  }

 }
