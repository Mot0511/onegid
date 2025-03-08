import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/auth/widgets/appbar_widget.dart';
import 'package:onegid/features/map/map.dart' hide AppBarWidget;
import 'package:onegid/features/posts/bloc/bloc.dart';
import 'package:onegid/features/posts/bloc/states.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/utils/prefs.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final UserBloc userBloc = GetIt.I<UserBloc>();
  final PostsBloc postsBloc = GetIt.I<PostsBloc>();

  void signout(BuildContext context) async {
    await removePrefs('login');
    Navigator.of(context).pushNamed('/signin');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        children: [
          AppBarWidget(),
          SizedBox(height: 20),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              bloc: userBloc,
              builder: (context, state) {
                if (state is UserStateLoaded) {
                  return Column(
                    children: [
                      Image.asset('assets/images/profile_image.png', width: 100, height: 100),
                      const SizedBox(height: 20),
                      Text(state.account.login, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 5),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('Выйти из аккаунта', style: theme.textTheme.titleMedium)
                        ),
                        onTap: () => signout(context)
                      ),
                    ],
                  );
                } else if (state is UserStateError) {
                  Fluttertoast.showToast(msg: 'При загрузке данных пользователя произошла ошибка');
                }
                return const CircularProgressIndicator();
              },
            )
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/promocodes'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Промокоды за\nактивность', style: theme.textTheme.labelLarge?.copyWith(color: Colors.white)),
                        GestureDetector(
                          child: Icon(Icons.chevron_right, color: Colors.white, size: 50)
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(height: 30),
                Text('Мои посты:', style: theme.textTheme.titleLarge),
                SizedBox(height: 10),
                BlocBuilder<PostsBloc, PostsState>(
                  bloc: postsBloc,
                  builder: (context, state) {
                    if (state is PostsStateLoaded && userBloc.state is UserStateLoaded) {
                      final List<Widget> children = [];
                      for (var post in state.posts) {
                        if (post.author == (userBloc.state as UserStateLoaded).account.login) {
                          children.add(PostWidget(post: post));
                        }
                      }
                      return Wrap(children: children);
                    } else if (state is PostsStateError) {
                      Fluttertoast.showToast(msg: 'При загрузке постов произошла ошибка');
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(height: 30),
                Text('Избранные места:', style: theme.textTheme.titleLarge),
                SizedBox(height: 10),
                BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    if (state is UserStateLoaded) {
                      return Column(
                        children: state.account.favPlaces.map((place) {
                          return PlaceItem(place: place);
                        }).toList(),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                )
              ],
            )
          )
        ],
      )
    );
  }
}