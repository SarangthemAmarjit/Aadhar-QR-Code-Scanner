import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:qrcodescanner/modal/xml_modal.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      {required String frontpath,
      required String filename1,
      required String backpath,
      required String filename2,
      required String name,
      required PrintLetterBarcodeData? metadata}) async {
    File file1 = File(frontpath);
    File file2 = File(backpath);
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
      await storage.ref('Aadhaar/$name/$filename1').putFile(file1);
      await storage.ref('Aadhaar/$name/$filename2').putFile(file2);
      await storage
          .ref('Aadhaar/$name/metadata.txt')
          .putFile(file1, newCustomMetadata);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
