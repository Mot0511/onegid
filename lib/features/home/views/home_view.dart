import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/home/home.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:onegid/services/fetchPosts.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:onegid/features/posts/models/models.dart' as model;

class Home extends StatefulWidget{
  const Home({super.key});

  State<Home> createState() => Home_();
}

class Home_ extends State<Home> {
  Home_();

  final PostsRepository posts_repository = GetIt.I<PostsRepository>();

  String login = '';
  List<model.PostModel>? posts;

  void getData() async {
    posts = await posts_repository.getPosts();
    setState(() {});
  }

  @override
  void initState() {
    getData();
  }

  void getLogin(context) async {
    final String? res = await getPrefs('login');
    if (res != null) {
      setState(() {
        login = (res as String);
      });
    } else {
      Navigator.of(context).pushNamed('/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    getLogin(context);
    final AccountModel? account = ModalRoute.of(context)!.settings.arguments as AccountModel?;
    // if (account != null) {
    //   Navigator.pushNamed(context, '/signin');
    // }
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: () async {
            return getData();
          },
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromRGBO(0, 201, 54, 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Image.asset('assets/images/main_menu/bonuses.png', width: 50, height: 50)
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed('/profile'),
                        child: Image.asset('assets/images/profile_image.png')
                      ),
                      const InkWell(
                        child: Icon(Icons.menu, size: 40, color: Colors.white),
                      ),
                    ],
                  )
                )
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color.fromRGBO(20, 184, 147, 1), Color.fromRGBO(151, 221, 156, 1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight                    
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    children: [
                      Text('Хороший день для прогулки, $login!', style: TextStyle(color: Colors.white, fontSize: 25)),
                    ],
                  )
                )
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Недавние посты', style: TextStyle(fontSize: 25, color: Colors.green))
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: posts == null ?
                  const Center(child: CircularProgressIndicator()) :
                  Builder(builder: (BuildContext context) {
                    List<Widget> children = [];
                    posts?.forEach((model.PostModel post) {
                      children.add(PostWidget(post: post));
                    });
                    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: children));
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
                  const Column(
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
      )
    );
  }
}


