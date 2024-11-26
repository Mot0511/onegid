import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onegid/models/Place.dart';
import 'package:onegid/models/Post.dart';
import 'package:onegid/services/fireFiles.dart';

Future<void> addPost(Post post) async {
  final db = FirebaseFirestore.instance;

  final points = post.places.map((Place place) => place.title);
  final data = {
    'author': '',
    'category': post.cat,
    'create_datetime': DateTime.timestamp(),
    'description': post.description,
    'photos': [{'name': 'photo1'}],
    'points': points,
    'title': post.title,
    'voices': []
  };

  db.collection('posts').add(data).then((snap) async {
    final id = snap.id;

    await uploadFiles([post.image], 'posts/$id/photo1.jpg');
  });
}


Future<List<Post>> getPosts() async {
  final db = FirebaseFirestore.instance;
  db.collection('posts').get().then((snap) {
    snap.docs.forEach((doc) {
      final data = doc.data();

      
    });
  });
}