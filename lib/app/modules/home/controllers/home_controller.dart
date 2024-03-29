import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_manipulation/app/modules/home/algorithms/naive_blur.dart';
import 'package:image_manipulation/app/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  Uint8List? get image => getImage();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Uint8List? getImage() {
    if (isOriginalShowed) {
      return _originalImage;
    }
    return (_imageImg == null) ? null : _image;
  }

  void changeStateOriginal(bool state) {
    isOriginalShowed = state;
    update();
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    File imageFile = File(pickedImage.path);
    Uint8List? _image = imageFile.readAsBytesSync();
    Image? _imageImg = decodeImage(_image);
    _imageImg = copyResize(_imageImg!, height: 480);
    _originalImage = Uint8List.fromList(encodeJpg(_imageImg));
    update();
  }

  void onTapEdit() async {
    if (_imageImg == null) return;
    _imageImg = await futureWithLoading(compute(naiveBlur, _imageImg!));
    _image = Uint8List.fromList(encodeJpg(_imageImg!));
    update();
  }

  void onTapClear() {
    _imageImg = null;
    _originalImage = null;
    _image = null;
    update();
  }

  /// staff
  /// Image to show in UI, it has been got from _imageImg
  Uint8List? _image;
  /// Original image to show in UI  
  Uint8List? _originalImage;

  Image? _imageImg;

  /// Image to edit
  bool isOriginalShowed = false;
  bool isProcessing = false;
}
