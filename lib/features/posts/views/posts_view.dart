import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/posts/bloc/bloc.dart';
import 'package:onegid/features/posts/bloc/events.dart';
import 'package:onegid/features/posts/bloc/states.dart';
import 'package:onegid/features/posts/models/models.dart' as model;
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:onegid/features/posts/widgets/add_btn_widget.dart';

class Posts extends StatefulWidget{
  Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  final PostsRepository posts_repository = GetIt.I<PostsRepository>();
  
  final PostsBloc postsBloc = GetIt.I<PostsBloc>();

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: const AddBtnWidget(path: 'addPost'),
      body: RefreshIndicator(
        color: theme.primaryColor,
        onRefresh: () async {
          final completer = Completer();
          postsBloc.add(LoadPosts(completer: completer));
          return completer.future;
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('assets/images/back_button_green.png', width: 50),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('ИНТЕРЕСНЫЕ ПОСТЫ', style: theme.textTheme.headlineMedium)
                  )
                ],
              )
            ),
            BlocBuilder<PostsBloc, PostsState>(
              bloc: postsBloc,
              builder: (context, state) {
                if (state is PostsStateLoaded) {
                  final List<PostWidget> children = state.posts.map((model.PostModel post) {
                    return PostWidget(post: post);
                  }).toList();
                  return Selection(categories: state.categories, children: children);
                } else if (state is PostsStateError) {
                  Fluttertoast.showToast(msg: 'При загрузке постов произошла ошибка');
                }
                return const Center(child: CircularProgressIndicator());
              }
            )
          ],
        ),
      )
    );
  }
}