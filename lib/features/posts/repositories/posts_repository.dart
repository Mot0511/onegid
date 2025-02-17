import 'package:flutter/material.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/repositories/base_repository.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as yandex_map;

class PostsRepository extends FirebaseRepository {

  Future<void> addPost(PostModel post) async {
    final points = {};
    post.places.forEach((Place place) {
      points[place.title] = [place.position.latitude, place.position.longitude];
    });

    final data = {
      'author': post.author,
      'category': post.cat,
      'create_datetime': DateTime.timestamp(),
      'description': post.description,
      'photos': [{'name': 'photo0'}],
      'points': points,
      'title': post.title,
      'voices': []
    };

    db.collection('posts').add(data).then((snap) async {
      final id = snap.id;
      await uploadFiles([post.image], 'posts/$id/photo0');
    });
  }


  Future<List<PostModel>> getPosts() async {

    final List<PostModel> posts = [];
    final snap = await db.collection('posts').get();
    for (var doc in snap.docs) {
      final id = doc.id;

      final data = doc.data();
      final String imageUrl = await getFireUrl('posts/$id/photo0');
      final List<Place> places = [];
      for (var entry in data['points'].entries) {
        places.add(Place(title: entry.key, position: yandex_map.Point(latitude: entry.value[0], longitude: entry.value[1])));
      }

      final categories = await getCategories();
      final PostModel post = PostModel(
        title: data['title'],
        description: data['description'],
        author: data['author'],
        image: NetworkImage(imageUrl),
        cat: (categories[data['category']] as String),
        catId: data['category'],
        places: places
      );
      posts.add(post);
    }

    return posts;
  }


  Future<Map<String, String>> getCategories() async {

    final Map<String, String> categories = {};
    final snap = await db.collection('categories').get();
    for (var doc in snap.docs) {
      final id = doc.id;
      final data = doc.data(); 
      categories[id] = data['title'];
    }

    return categories;
  }
}