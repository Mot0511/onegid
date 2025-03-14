import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseRepository {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<String> getFireUrl(String refPath) async {
    final storageRef = storage.ref();
    final String url = await storageRef.child(refPath).getDownloadURL();

    return url;
  }

  Future<void> uploadFiles(List<File> files, List paths) async {
    for (var i = 0; i < files.length; i++) {
      final ref = storage.ref(paths[i]);
      await ref.putFile(files[i]);
    }
  }
}