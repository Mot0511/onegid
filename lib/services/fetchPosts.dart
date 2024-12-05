import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onegid/models/Place.dart';
import 'package:onegid/models/Post.dart';
import 'package:onegid/services/fetchCategories.dart';
import 'package:onegid/services/fireFiles.dart';
import 'package:onegid/utils/getGeoPosition.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';

Future<void> addPost(Post post) async {
  final db = FirebaseFirestore.instance;

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


Future<List<Post>> getPosts() async {
  final db = FirebaseFirestore.instance;

  final List<Post> posts = [];
  final snap = await db.collection('posts').get();
  for (var doc in snap.docs) {
    final id = doc.id;

    final data = doc.data();
    final String imageUrl = await getFireUrl('posts/$id/photo0');
    final List<Place> places = [];
    for (var entry in data['points'].entries) {
      places.add(Place(title: entry.key, position: Point(latitude: entry.value[0], longitude: entry.value[1])));
    }

    final categories = await getCategories();
    final Post post = Post(
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