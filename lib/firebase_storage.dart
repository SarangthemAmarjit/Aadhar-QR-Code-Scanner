import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      {required String filepath,
      required String filename,
      required String name}) async {
    File file = File(filepath);

    try {
      await storage.ref('Aadhaar/$name/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
