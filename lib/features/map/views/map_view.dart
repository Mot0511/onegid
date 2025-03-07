import 'package:flutter/material.dart' hide TextStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' hide MapMode, Image;
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/search.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';
import 'package:yandex_maps_mapkit/src/bindings/image/image_provider.dart' as image_provider;
import 'package:sliding_up_panel/sliding_up_panel.dart';
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

  final UserBloc userBloc = GetIt.I<UserBloc>();

  Place? choosenPlace;

  final PanelController panelController = PanelController();
  
  final searchManager = SearchFactory.instance.createSearchManager(SearchManagerType.Combined);

  late final geoObjectTapListener = GeoObjectTapListenerImpl(callback: (event) {
    final geoObject = event.geoObject;
    if (geoObject.name != null) {
      final uri = geoObject.metadataContainer.get(UriObjectMetadata.factory)?.uris.first.value;
      final place = Place(title: geoObject.name, position: geoObject.geometry[0].asPoint(), uri: uri);
      setState(() {
        choosenPlace = place;
        choosenPlaces.add(place);
      });
    }
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
            final uri = geoObject.metadataContainer.get(UriObjectMetadata.factory)?.uris.first.value;
            final Place place = Place(title: geoObject.name ?? '', position: geoObject.geometry[0].asPoint() ?? Point(latitude: 0, longitude: 0), uri: uri);
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

  void setPosition({latitude = 58.603595, longitude = 49.668023, zoom = 15.0}) {
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
    final theme = Theme.of(context);
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
              ],
            ),
            if (mapArguments.mode == MapMode.choosePlaces)
            BottomPlacesPanel(panelController: panelController, choosenPlaces: choosenPlaces)
            else if (mapArguments.mode != MapMode.choosePlaces && choosenPlace != null && userBloc.state is UserStateLoaded)
            BottomInfoPanel(panelController: panelController, choosenPlace: choosenPlace)

          ],
        ),
      )
    );
  }
}




