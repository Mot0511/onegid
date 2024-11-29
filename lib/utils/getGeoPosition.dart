import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as mapkit;

Future<mapkit.Point> getGeoPosition(title) async {
  final YandexGeocoder geocoder = YandexGeocoder(apiKey: '0e9210b1-ae2a-440d-a5c0-3011c6229923');
  final GeocodeResponse res = await geocoder.getGeocode(DirectGeocodeRequest(
    addressGeocode: title,
    lang: Lang.enRu,
  ));
  final mapkit.Point point = mapkit.Point(latitude: (res.firstPoint?.lat as double), longitude: (res.firstPoint?.lon as double));
  
  return point;
}