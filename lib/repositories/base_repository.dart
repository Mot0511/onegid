import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseRepository {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<String> getFireUrl(String refPath) async {
    print(refPath);
    final storageRef = FirebaseStorage.instance.ref();
    final String url = await storageRef.child(refPath).getDownloadURL();

    return url;
  }

  Future<void> uploadFiles(List<File> files, String refPath) async {
    final storageRef = FirebaseStorage.instance.ref();
    final ref = await storageRef.child(refPath);

    files.forEach((File file) async {
      await ref.putFile(file);
    });
  }
}