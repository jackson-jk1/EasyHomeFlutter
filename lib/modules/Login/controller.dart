import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var imageURL = '';

  void uploadImage(ImageSource imageSource) async {
    try {
      final pickedFile = await ImagePicker().getImage(source: imageSource);
      isLoading(true);
      if (pickedFile != null) {

        Get.snackbar('Success', 'Image uploaded successfully',
            margin: EdgeInsets.only(top: 5,left: 10,right: 10));
      }
      else {
        Get.snackbar('Failed', 'Image not selected',
        margin: EdgeInsets.only(top: 5,left: 10,right: 10));
      }
    } finally {
    isLoading(false);
    }
  }
}