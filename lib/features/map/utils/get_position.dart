import 'package:dio/dio.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';

Future<Point> getPosition(String region) async {

  final dio = Dio();
  final res = await dio.get('https://geocode-maps.yandex.ru/1.x/?apikey=0e9210b1-ae2a-440d-a5c0-3011c6229923&geocode=${region}&format=json');
  final data = res.data['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['Point']['pos'].split(' ');

  return Point(latitude: double.parse(data[1]), longitude: double.parse(data[0]));
}