import 'package:yandex_maps_mapkit/mapkit.dart';

class Place {
  const Place({required this.title, required this.position});

  final String title;
  final Point position;
}