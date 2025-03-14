import 'package:flutter/material.dart' hide TextStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/map/utils/get_position.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:yandex_maps_mapkit/directions.dart';
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

  late final drivingRouteListener = DrivingSessionRouteListener(
    onDrivingRoutes: (List<DrivingRoute> routes) {
      final route = routes[0];
      final polyline = route.geometry;
      final polylineObject = _mapWindow?.map.mapObjects.addPolylineWithGeometry(polyline);
      polylineObject?.setStrokeColor(Colors.green);
    },
    onDrivingRoutesError: (error) {}
  );

  late final searchSessionListener = SearchSessionSearchListener(
    onSearchResponse: (SearchResponse response){
      print('In listener');
      final geoObjects = response.collection
        .children
        .map((it) => it.asGeoObject())
        .whereType<GeoObject>();
        
        _mapWindow!.map.mapObjects.clear();
        geoObjects.forEach((geoObject) {
          final Point position = geoObject.geometry[0].asPoint() ?? Point(latitude: 0, longitude: 0);
          addPlacemark(position);
        });
        },
        onSearchError: (error){},
      );

  
  void addPlacemark(Point position){
    final imageProvider = image_provider.ImageProvider.fromImageProvider(const AssetImage("assets/images/point.png"));
    _mapWindow!.map.mapObjects.addPlacemark()
      ..geometry = position
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
      print('After session');
    }
  }

  Future<void> setPosition({position, zoom = 13.0}) async {
    if (userBloc.state is UserStateLoaded) {
      _mapWindow!.map.move(
        CameraPosition(
          position,
          zoom: zoom,
          azimuth: 0,
          tilt: 0,
        )
      );
    }
  }

  void clearPlaces() {
    setState(() {choosenPlaces = [];});
  }

  void makeRoute(List<Place> places) {
    final drivingRouter = DirectionsFactory.instance.createDrivingRouter(DrivingRouterType.Combined);  
    final drivingOptions = DrivingOptions(routesCount: 1);
    final vehicleOptions = DrivingVehicleOptions(); 
    final points = places.map((place) => 
      RequestPoint(place.position, RequestPointType.Waypoint, null, null, null)
    ).toList();
    final drivingSession = drivingRouter.requestRoutes(
      drivingOptions,
      vehicleOptions,
      drivingRouteListener,
      points: points,
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
              final position = await getPosition((userBloc.state as UserStateLoaded).account.region);
              await setPosition(position: position);
              if (mapArguments.mode == MapMode.search){
                search(mapArguments.argument);
              } else if (mapArguments.mode == MapMode.showPlaces){
                final places = mapArguments.argument[0];
                final selectedPlace = mapArguments.argument[1];
                // final routeType = mapArguments.argument[2];
                places.forEach((place) => addPlacemark(place.position));
                makeRoute(places);
                await setPosition(position: selectedPlace.position, zoom: 15.0);
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
              BottomPlacesPanel(panelController: panelController, choosenPlaces: choosenPlaces, clearPlaces: clearPlaces)
            else if (mapArguments.mode != MapMode.choosePlaces && choosenPlace != null && userBloc.state is UserStateLoaded)
              BottomInfoPanel(panelController: panelController, choosenPlace: choosenPlace)

          ],
        ),
      )
    );
  }
}




