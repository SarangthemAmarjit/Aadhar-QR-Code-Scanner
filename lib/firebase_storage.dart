import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:qrcodescanner/modal/xml_modal.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      {required String filepath,
      required String filename,
      required String name,
      required PrintLetterBarcodeData? metadata}) async {
    File file = File(filepath);
    final newCustomMetadata = SettableMetadata(
      contentType: 'text/html',
      customMetadata: {
        "Name": metadata!.name.toString(),
        "Aadhaar Number": metadata.uid.toString(),
        "Address": metadata.loc.toString(),
        "Gender": metadata.gender.toString(),
        "Date of Birth": metadata.dob.toString(),
        "District": metadata.dist.toString(),
      },
    );
    try {
      await storage.ref('Aadhaar/$name/$filename').putFile(file);
      await storage
          .ref('Aadhaar/$name/metadata.txt')
          .putFile(file, newCustomMetadata);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
