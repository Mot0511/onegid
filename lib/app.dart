import 'package:flutter/material.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/home/home.dart';
import 'package:onegid/features/profile/profile.dart';
import 'package:onegid/themes/dark.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:onegid/themes/light.dart';

class OneGid extends StatefulWidget {
  const OneGid({super.key});

  State<OneGid> createState() => OneGid_();
}


class OneGid_ extends State<OneGid>{
  OneGid_();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darkTheme,
      theme: ligthTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/addPost',
      routes: {
        '/': (context) => Home(),
        '/map': (context) => MapScreen(),
        '/posts': (context) => Posts(),
        '/addPost': (context) => AddPost(),
        '/signin': (context) => Signin(),
        '/signup': (context) => Signup(),
        '/profile': (context) => ProfileView()
      },
    );
  }
}