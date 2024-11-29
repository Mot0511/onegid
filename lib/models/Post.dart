import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onegid/models/Place.dart';

class Post {
  final String title;
  final String description;
  final image;
  final String cat;
  final List<Place> places;

  const Post({required this.title, required this.description, required this.image, required this.cat, required this.places});
}