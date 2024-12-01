import 'package:flutter/material.dart';
import 'package:onegid/components/bottomNav.dart';
import 'package:onegid/components/menu.dart';
import 'package:onegid/components/menuItem.dart';
import 'package:onegid/components/post.dart';
import 'package:onegid/screens/map.dart';
import 'package:onegid/services/fetchPosts.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:onegid/models/Post.dart' as model;

class Home extends StatefulWidget{
  const Home({super.key});

  State<Home> createState() => Home_();
}

class Home_ extends State<Home> {
  Home_();

  String login = '';
  late Future<List<model.Post>> posts = getPosts();

  @override
  void initState() {
    getLogin();
  }

  void getLogin() async {
    final String? res = await getPrefs('login');
    if (login != null) {
      setState(() {
        login = (res as String);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromRGBO(0, 201, 54, 1)
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Image.asset('assets/images/main_menu/bonuses.png', width: 50, height: 50)
                      ),
                      InkWell(
                        child: Image.asset('assets/images/main_menu/profile_image.png')
                      ),
                      InkWell(
                        child: Icon(Icons.menu, size: 40, color: Colors.white),
                      ),
                    ],
                  )
                )
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(20, 184, 147, 1), Color.fromRGBO(151, 221, 156, 1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight                    
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      Text('Хороший день для прогулки, $login!', style: TextStyle(color: Colors.white, fontSize: 25)),
                    ],
                  )
                )
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Недавние посты', style: TextStyle(fontSize: 25, color: Colors.green))
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: FutureBuilder(future: posts, builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  List<Widget> children = [];
                  final data = snap.data;
                  data.forEach((model.Post post) {
                    children.add(Post(post: post));
                  });
                  return Row(children: children);
                } else if (snap.hasError) {
                  return Text('Произошла ошибка');
                } else {
                  return CircularProgressIndicator();
                }
              })
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/posts'),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Посмотреть другие посты =>', style: TextStyle(color: Colors.grey, fontSize: 22))
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Что Вы ищете?', style: TextStyle(fontSize: 25, color: Colors.green))
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/map', arguments: MapArguments(mode: MapMode.classic)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                      child:  Column(
                      children: [
                        Image.asset('assets/images/main_menu/open_map.png', width: 120),
                        Text('Открыть\nкарту', style: TextStyle(color: Colors.green), textAlign: TextAlign.center)
                      ],
                    )
                  )
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuItem(title: 'Музеи', image: 'museums.png'),
                        MenuItem(title: 'Парки', image: 'parks.png'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuItem(title: 'Отели', image: 'hotel.png'),
                        MenuItem(title: 'Развлечения', image: 'recreation.png'),
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}


