import 'dart:io';

import 'package:onegid/features/map/map.dart';

class PostModel {
  final String title;
  final String description;
  final String author;
  final image;
  final String cat;
  final String catId;
  final List<Place> places;
  // final String routeType;
  final String region;
  final audios;

  const PostModel({
    required this.title, 
    required this.description, 
    required this.image, 
    required this.audios,
    required this.cat, 
    required this.catId, 
    required this.author, 
    required this.places,
    // required this.routeType,
    required this.region,
  });
}