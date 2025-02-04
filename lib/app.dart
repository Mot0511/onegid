import 'package:flutter/material.dart';
import 'package:onegid/utils/prefs.dart';

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