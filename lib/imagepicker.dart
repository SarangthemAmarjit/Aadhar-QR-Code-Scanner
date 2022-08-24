import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcodescanner/firebase_storage.dart';
import 'package:qrcodescanner/modal/xml_modal.dart';

class AadhaarImagePicker extends StatefulWidget {
  final String btn;
  final String fullname;
  final String adharname;
  final PrintLetterBarcodeData? metadata;
  const AadhaarImagePicker(
      {Key? key,
      required this.btn,
      required this.adharname,
      required this.fullname,
      required this.metadata})
      : super(key: key);

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

  final Storage storage = Storage();
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
              storage
                  .uploadFile(
                      filename: widget.adharname,
                      filepath: val.path,
                      name: widget.fullname,
                      metadata: widget.metadata)
                  .then((value) => log('Done Upload'));
            },
            child: Text(widget.btn),
          ),
        ),
      ],
    );
  }
}
