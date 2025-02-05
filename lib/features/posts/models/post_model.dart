import 'package:onegid/features/map/map.dart';

class PostModel {
  final String title;
  final String description;
  final String author;
  final image;
  final String cat;
  final String catId;
  final List<Place> places;

  const PostModel({required this.title, required this.description, required this.image, required this.cat, required this.catId, required this.author, required this.places});
}