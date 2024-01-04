import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/string_constant.dart';
import '../../common_mixin_widgets/common_mixin_widget.dart';

class HomeProvider with ChangeNotifier, CommonWidgets {
  File picture = File("");
  String url =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHh3xq0QcYk0CxXUpm2cjhPGVF_9DYPGDcy4M1yXAi2FKyuxu2FHcgEHr_Og&s";

  get(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        commonSnackBar(context: context, message: "HomeProvider");
      },
    );
  }
  Future<void> deviceToken() async {
    StringConstant.deviceToken1 = (await FirebaseMessaging.instance.getToken())!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringConstant.deviceToken, StringConstant.deviceToken1);
    print('DEVICE_TOKEN1!!! :-> ${StringConstant.deviceToken1}');
  }
  Future<void> requestPermissionsAndPickImage(ImageSource source, BuildContext context) async {
    PermissionStatus photoStatus = await Permission.photos.status;
    PermissionStatus cameraStatus = await Permission.camera.status;

    if (photoStatus.isPermanentlyDenied || cameraStatus.isPermanentlyDenied) {
      commonToast(errorMessage: "Please Allow Photo and Camera Permissions To Proceed");

      if (Platform.isAndroid) {
        openAppSettings();
      } else if (Platform.isIOS) {
        AppSettings.openAppSettings();
      }

      return;
    }

    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        File? croppedFile = await cropImage(pickedFile.path);

        if (croppedFile != null) {
          picture = croppedFile;
          notifyListeners();
          Navigator.of(context).pop();
        } else {
          commonToast(errorMessage: "Canceled or Failed Cropping.");
        }
      }
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied' || e.code == 'camera_access_denied') {
        commonToast(errorMessage: "Photo or Camera access denied");
      } else {
        rethrow;
      }
    }
  }

  Future<File?> cropImage(String imagePath) async {
    File? croppedFile;
    try {
      final imageCropper = ImageCropper();
      final cropperFile = await imageCropper
          .cropImage(sourcePath: imagePath, aspectRatioPresets: [
        CropAspectRatioPreset.square
      ], uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            cropFrameStrokeWidth: 1,
            hideBottomControls: true,
            cropFrameColor: Colors.yellow,
            backgroundColor: Colors.black),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ]);
      if (cropperFile != null) {
        croppedFile = File(cropperFile.path);
      }
    } catch (e) {
      commonToast(errorMessage: 'Error cropping image. \n' '$e');
      print('Error cropping image: $e');
    }
    return croppedFile;
  }
}
