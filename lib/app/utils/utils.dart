import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Pick image from gallery/camera
/// [source] : gallery or camera
/// [crop] : crop image
Future<File?> utilPickImage(ImageSource source, bool crop) async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: source);
  if (image == null) return null;
  if (crop) {
    File? file;
    file = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (file != null) return file;
  }
  return File(image.path);
}

/// While an image is processing it shows a circular progress indicator
Future<T> futureWithLoading<T>(Future<T> future) async {
  Get.dialog(
    Stack(
      children: const [
        Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
  final _result = await future;
  Get.back();
  return _result;
}

/// clamp a value between 0 and 255 and convert to int 
int fillNumber(double number) {
  if (number < 0) return 0;
  if (number > 255) return 255;
  return number.toInt();
}