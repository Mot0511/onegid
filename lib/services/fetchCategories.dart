import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, String>> getCategories() async {
  final db = FirebaseFirestore.instance;

  final Map<String, String> categories = {};
  final snap = await db.collection('categories').get();
  for (var doc in snap.docs) {
    final id = doc.id;
    final data = doc.data(); 
    categories[id] = data['title'];
  }

  return categories;
}