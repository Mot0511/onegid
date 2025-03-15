import 'package:yandex_maps_mapkit/mapkit.dart';

class Place {
  const Place({required this.title, required this.position, required this.uri});

  final String title;
  final Point position;
  final String uri;
}