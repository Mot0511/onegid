import 'package:flutter/material.dart' hide TextStyle;
import 'package:yandex_maps_mapkit/mapkit.dart' hide MapMode;
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/search.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';
import 'package:yandex_maps_mapkit/src/bindings/image/image_provider.dart' as image_provider;

import 'package:onegid/features/map/map.dart';


class MapScreen extends StatefulWidget{
  MapScreen({super.key});

  State<MapScreen> createState() => _MapScreen();
}

class GeoObjectTapListenerImpl implements LayersGeoObjectTapListener {
  const GeoObjectTapListenerImpl({required this.callback});
  final Function callback;

  @override
  bool onObjectTap(GeoObjectTapEvent event) => callback(event);
}

class _MapScreen extends State<MapScreen>{

  MapWindow? _mapWindow;
  List<Place> choosenPlaces = [];

  late final geoObjectTapListener = GeoObjectTapListenerImpl(callback: (event) {
    final geoObject = event.geoObject;
    setState(() {
      choosenPlaces.add(Place(title: geoObject.name, position: geoObject.geometry[0].asPoint()));
    });
    return true;
  });

  late final searchSessionListener = SearchSessionSearchListener(
    onSearchResponse: (SearchResponse response){
      final geoObjects = response.collection
        .children
        .map((it) => it.asGeoObject())
        .whereType<GeoObject>();
        
        _mapWindow!.map.mapObjects.clear();
        geoObjects.forEach((geoObject) {
          if (geoObject != null){
            final Place place = Place(title: geoObject.name ?? '', position: geoObject.geometry[0].asPoint() ?? Point(latitude: 0, longitude: 0));
            addPlacemark(place);
          }
        });
        },
        onSearchError: (error){},
      );

  
  void addPlacemark(Place place){
    final imageProvider = image_provider.ImageProvider.fromImageProvider(const AssetImage("assets/images/point.png"));
    _mapWindow!.map.mapObjects.addPlacemark()
      ..geometry = place.position as Point
      ..setIcon(imageProvider);
  }


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

  void setPosition({latitude = 58.603595, longitude = 49.668023, zoom = 12.0}) {
    _mapWindow!.map.move(
        CameraPosition(
          Point(latitude: latitude, longitude: longitude),
          zoom: zoom,
          azimuth: 0,
          tilt: 0,
        )
      );
  }


  @override
  Widget build(BuildContext context){
    final mapArguments = ModalRoute.of(context)!.settings.arguments as MapArguments;
    return (
      Scaffold(
        body: Stack(
          children: [
            YandexMap(onMapCreated: (mapWindow) async {
              _mapWindow = mapWindow;
              mapkit.onStart();
              mapWindow.map.addTapListener(geoObjectTapListener);
              setPosition();
              if (mapArguments.mode == MapMode.showPlaces){
                search(mapArguments.argument);
              } else if (mapArguments.mode == MapMode.showPlace){
                final Place place = mapArguments.argument;
                addPlacemark(place);
                setPosition(latitude: place.position.latitude, longitude: place.position.longitude, zoom: 15.0);
              }
            }),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
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
                ),
                if (mapArguments.mode == MapMode.choosePlaces)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: List.generate(choosenPlaces.length, (i) => Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(choosenPlaces[i]!.title)
                            ))
                          )
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context, choosenPlaces),
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text('Создать маршрут')
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(() {choosenPlaces = [];}),
                                child: Text('Очистить'),
                              )
                            ]
                          )
                        )
                      )
                    ]
                  )
                )
              ],
            )
          ],
        ),
      )
    );
  }
}




