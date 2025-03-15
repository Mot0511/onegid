import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/posts/models/category.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/repositories/base_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as yandex_map;

class PostsRepository extends FirebaseRepository {

  final UserBloc userBloc = GetIt.I<UserBloc>();
  final Uuid uuid = Uuid();

  Future<void> addPost(PostModel post) async {
    final postUuid = uuid.v4();

    final points = {};
    post.places.forEach((Place place) {
      points[place.uri] = place.title;
    });

    final audiogidsUuids = post.audios.map((_) => uuid.v4()).toList();
    final data = {
      'author': post.author,
      'category': post.cat,
      'create_datetime': DateTime.timestamp(),
      'description': post.description,
      'photos': [{'name': 'photo0'}],
      'points': points,
      'title': post.title,
      'voices': audiogidsUuids,
      'region': post.region,
    };

    db.collection('posts').doc(postUuid).set(data).then((snap) async {
      await uploadFiles([post.image], ['posts/$postUuid/photo0']);
      await uploadFiles((post.audios as List<File>), audiogidsUuids.map((uuid) => 'posts/$postUuid/$uuid.mp3').toList());
    });
  }


  Future<List<PostModel>> getPosts(String email) async {
    final List<PostModel> posts = [];

    final res = await db.collection('users').doc(email).get();
    final account = res.data();

    final snap = await db.collection('posts').where('region', isEqualTo: account?['region']).get();
    for (var doc in snap.docs) {
      final id = doc.id;

      final data = doc.data();
      final String imageUrl = await getFireUrl('posts/$id/photo0');
      final List<Place> places = [];
      for (var entry in data['points'].entries) {
        places.add(Place(title: entry.value, position: yandex_map.Point(latitude: entry.value[0], longitude: entry.value[1]), uri: entry.key));
      }

      final List<Category> categories = await getCategories();
      final String category = categories.where((category) => category.id == data['category']).toList()[0].id;

      final List<String> audiogidsUrls = [];
      for (var uuid in data['voices']) {
        audiogidsUrls.add(await getFireUrl('posts/$id/$uuid.mp3'));
      }

      final PostModel post = PostModel(
        title: data['title'],
        description: data['description'],
        author: data['author'],
        image: NetworkImage(imageUrl),
        cat: category,
        catId: data['category'],
        places: places,
        // routeType: data.containsKey('routeType') ? data['routeType'] : '0',
        region: data.containsKey('region') ? data['region'] : null,
        audios: audiogidsUrls
      );
      posts.add(post);
    }

    return posts;
  }


  Future<List<Category>> getCategories() async {
    final snap = await db.collection('categories').get();

    final List<Category> categories = snap.docs.map((doc) {
        final id = doc.id;
        final data = doc.data(); 
        return Category(id: id, title: data['title']);
      }
    ).toList();

    return categories;
  }
}