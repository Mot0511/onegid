import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> getFireUrl(String refPath) async {
  final storageRef = FirebaseStorage.instance.ref();
  final url = await storageRef.child(refPath).getDownloadURL();

  return url;
}

Future<void> uploadFiles(List<File> files, String refPath) async {
  final storageRef = FirebaseStorage.instance.ref();
  final ref = await storageRef.child(refPath);

  files.forEach((File file) async {
    await ref.putFile(file);
  });
}