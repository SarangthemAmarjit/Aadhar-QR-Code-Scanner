import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

onImageButtonPressed(ImageSource source,
    {BuildContext? context, capturedImageFile}) async {
  final ImagePicker picker = ImagePicker();
  CroppedFile? val;

  final pickedFile = await picker.pickImage(
    source: source,
  );

  val = await ImageCropper().cropImage(
    uiSettings: [
      AndroidUiSettings(
        toolbarColor: Colors.white,
        toolbarTitle: "genie cropper",
      )
    ],
    sourcePath: pickedFile!.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    compressQuality: 100,
    maxHeight: 400,
    maxWidth: 400,
    compressFormat: ImageCompressFormat.jpg,
  );
  print("cropper ${val.runtimeType}");
  capturedImageFile(val!.path);
}

typedef capturedImageFile = String Function(String);
typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
