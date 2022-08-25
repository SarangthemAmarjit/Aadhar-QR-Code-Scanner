import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrcodescanner/services/firebase_storage.dart';
import 'package:qrcodescanner/modal/xml_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AadhaarImagePicker extends StatefulWidget {
  final String Uploadname;

  final String filepath;
  const AadhaarImagePicker(
      {Key? key, required this.filepath, required this.Uploadname})
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

  Widget build(BuildContext context) {
    return Column(
      children: [
        image != null
            ? Image.file(
                image!,
                height: 100,
                width: 188,
              )
            : InkWell(
                onTap: () async {
                  var img = await _picker.pickImage(source: ImageSource.camera);
                  final Future<SharedPreferences> _prefs =
                      SharedPreferences.getInstance();
                  final SharedPreferences prefs = await _prefs;

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

                  prefs.setString(widget.filepath, val.path);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.upload),
                      Text(widget.Uploadname)
                    ],
                  ),
                  width: 188,
                  height: 100,
                ),
              ),
      ],
    );
  }
}
