import 'package:flutter/material.dart';
import 'package:onegid/models/Place.dart';
import 'package:onegid/screens/addPost.dart';
import 'package:onegid/screens/home.dart';
import 'package:onegid/screens/map.dart';
import 'package:onegid/screens/posts.dart';
import 'package:onegid/screens/signin.dart';
import 'package:onegid/screens/signup.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(
    apiKey: "da3e48c8-a6ca-477f-88da-f4ef06e563ae"
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OneGid());
}

class OneGid extends StatefulWidget {
  const OneGid({super.key});

  State<OneGid> createState() => OneGid_();
}


class OneGid_ extends State<OneGid>{
  OneGid_();

  bool isSigned = false;

  @override
  void initState() {
    getLogin();
  }

  void getLogin() async {
    final String? login = await getPrefs('login');
    if (login != null){
      isSigned = true;
    } else {
      isSigned = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signin',
      routes: {
        '/': (context) => Home(),
        '/map': (context) => MapScreen(),
        '/posts': (context) => Posts(),
        '/addPost': (context) => AddPost(),
        '/signin': (context) => Signin(),
        '/signup': (context) => Signup(),
      },
    );
  }
}