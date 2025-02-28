import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/home/home.dart';
import 'package:onegid/features/posts/bloc/bloc.dart';
import 'package:onegid/features/posts/bloc/events.dart';
import 'package:onegid/features/posts/bloc/states.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:onegid/features/posts/models/models.dart' as model;

class Home extends StatefulWidget{
  const Home({super.key});

  State<Home> createState() => Home_();
}

class Home_ extends State<Home> {
  Home_();

  final PostsRepository posts_repository = GetIt.I<PostsRepository>();


  final UserBloc userBloc = GetIt.I<UserBloc>();
  final PostsBloc postsBloc = GetIt.I<PostsBloc>();
  
  @override
  void initState() {
    postsBloc.add(LoadPosts());
  }

  void getAccount(context) async {
    final String? email = await getPrefs('email');
    if (email != null) {
      userBloc.add(LoadUser(email: email));
    } else {
      Navigator.of(context).pushNamed('/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    getAccount(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          color: theme.primaryColor,
          onRefresh: () async {
            final completer = Completer();
            postsBloc.add(LoadPosts(completer: completer));
            return completer.future;
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
                        onTap: () => Navigator.of(context).pushNamed('/promocodes'),
                        child: Image.asset('assets/images/main_menu/bonuses.png', width: 50, height: 50)
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed('/profile'),
                        child: Image.asset('assets/images/profile_image.png')
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed('/settings'),
                        child: const Icon(Icons.menu, size: 40, color: Colors.white),
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
                child: BlocBuilder<UserBloc, UserState>(
                  bloc: userBloc,
                  builder: (context, state) {
                    if (state is UserStateLoaded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Column(
                          children: [
                            Text('Хороший день для прогулки, ${state.account.login}!', style: TextStyle(color: Colors.white, fontSize: 25)),
                          ],
                        )
                      );
                    } else if (state is UserStateError) {
                      Fluttertoast.showToast(msg: 'При загрузке данных пользователя произошла ошибка');
                      
                    } 
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator())
                    );
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Недавние посты', style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor))
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: BlocBuilder<PostsBloc, PostsState>(
                  bloc: postsBloc,
                  builder: (context, state) {
                    if (state is PostsStateLoaded) {
                      List<Widget> children = [];
                      if (state.posts.length > 5) {
                        for (var i = 1; i <= 5; i++) {
                          children.add(PostWidget(post: state.posts[state.posts.length - i]));
                        }
                      } else {
                        children = state.posts.map((model.PostModel post) => PostWidget(post: post)).toList();
                      }
                      return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: children));
                    } else if (state is PostsStateError) {
                      Fluttertoast.showToast(msg: 'При загрузке постов произошла ошибка');
                    } 
                    return const Center(child: CircularProgressIndicator());
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
                  child: Text('Что Вы ищете?', style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor))
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
                          Text('Открыть\nкарту', style: theme.textTheme.labelMedium?.copyWith(color: theme.primaryColor), textAlign: TextAlign.center)
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


