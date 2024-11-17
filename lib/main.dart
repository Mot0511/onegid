import 'package:flutter/material.dart';
import 'package:onegid/models/Place.dart';
import 'package:onegid/screens/home.dart';
import 'package:onegid/screens/map.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(
    apiKey: "da3e48c8-a6ca-477f-88da-f4ef06e563ae"
  );
  runApp(const OneGid());
}

class OneGid extends StatelessWidget {
  const OneGid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home()
    );
  }
}
