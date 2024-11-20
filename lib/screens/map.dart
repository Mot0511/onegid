import 'package:flutter/material.dart' hide TextStyle;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/search.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';
import 'package:onegid/utils/getCurrentPosition.dart';
import 'package:yandex_maps_mapkit/src/bindings/image/image_provider.dart'
    as image_provider;

import 'package:onegid/models/Place.dart';


class MapScreen extends StatefulWidget{
  MapScreen({super.key});

  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen>{

  MapWindow? _mapWindow;

  late final searchSessionListener = SearchSessionSearchListener(
    onSearchResponse: (SearchResponse response){
      final geoObjects = response.collection
        .children
        .map((it) => it.asGeoObject())
        .whereType<GeoObject>();
        print('---------GEOOBJECTS-----------');
        
        final List<Place> places = [];
        geoObjects.forEach((geoObject) {
          if (geoObject != null){
            final Place place = Place(title: geoObject.name, position: geoObject.geometry[0].asPoint());
            places.add(place);
          }
        });
        _mapWindow!.map.mapObjects.clear();
        print(places);
        places.forEach((place) {
          final imageProvider = image_provider.ImageProvider.fromImageProvider(const AssetImage("assets/point.png"));
          final placemark = _mapWindow!.map.mapObjects.addPlacemark()
            ..geometry = (place.position as Point)
            ..setIcon(imageProvider);
          }
        );
        },
        onSearchError: (error){},
      );


  void search(searchText) {
    if (searchText != null){
      final searchManager = SearchFactory.instance.createSearchManager(SearchManagerType.Combined);
      final searchOptions = SearchOptions(
        searchTypes: SearchType.Biz,
        resultPageSize: 32,
      );
      final session = searchManager.submit(
        VisibleRegionUtils.toPolygon(_mapWindow!.map.visibleRegion),
        searchOptions,
        searchSessionListener,
        text: searchText,
      );
    }
  }

  void setPosition({latitude = 58.603595, longitude = 49.668023}) {
    _mapWindow!.map.move(
        CameraPosition(
          Point(latitude: latitude, longitude: longitude),
          zoom: 12.0,
          azimuth: 0,
          tilt: 0,
        )
      );
  }

  @override
  Widget build(BuildContext context){
    final searchText = ModalRoute.of(context)!.settings.arguments;
    return (
      Scaffold(
        body: Stack(
          children: [
            YandexMap(onMapCreated: (mapWindow) async {
              _mapWindow = mapWindow;
              mapkit.onStart();
              // final currentPosition = await getCurrentPosition();
              setPosition();
              search(searchText);
            }),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                color: Colors.white,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Поиск",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: const Color(0xFFFFFFFF),
                      )
                    ),
                  ),
                  onSubmitted: search,
                )
              )
            )
          ],
        ),
      )
    );
  }
}

// final class MapObjectTapListenerImpl implements MapObjectTapListener {

//   @override
//   bool onMapObjectTap(MapObject mapObject, Point point) {
//     showSnackBar("Tapped the placemark: Point(latitude: ${point.latitude}, longitude: ${point.longitude})");
//     return true;
//   }
// }

class MapArguments {
  final String searchText;

  const MapArguments({required this.searchText});
}