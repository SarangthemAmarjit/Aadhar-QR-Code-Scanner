import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcodescanner/main.dart';

class AadhaarImagePicker extends StatefulWidget {
  final String btn;
  const AadhaarImagePicker({Key? key, required this.btn}) : super(key: key);

  @override
  State<AadhaarImagePicker> createState() => _AadhaarImagePickerState();
}

class _AadhaarImagePickerState extends State<AadhaarImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? Image.file(
                image!,
                height: 100,
                width: 188,
              )
            : Container(
                height: 100,
              ),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              var img = await _picker.pickImage(source: ImageSource.camera);

              CroppedFile? val = await ImageCropper().cropImage(
                uiSettings: [
                  AndroidUiSettings(
                    toolbarColor: Colors.white,
                    toolbarTitle: "Image Cropper",
                  )
                ],
                sourcePath: img!.path,
                aspectRatio: const CropAspectRatio(ratioX: 20, ratioY: 13),
                maxHeight: 600,
                maxWidth: 600,
                compressFormat: ImageCompressFormat.jpg,
              );
              final temp = File(val!.path);
              setState(() {
                image = temp;
              });

              // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              //     "#ff6666", "Cancel", true, ScanMode.QR);
            },
            child: Text(widget.btn),
          ),
        ),
      ],
    );
  }
}
