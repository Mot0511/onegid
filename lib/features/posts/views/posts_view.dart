import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/posts/models/models.dart' as model;
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:onegid/features/posts/widgets/add_btn_widget.dart';
import 'package:onegid/services/fetchPosts.dart';

class Posts extends StatefulWidget{
  Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {

  final PostsRepository posts_repository = GetIt.I<PostsRepository>();

  List<model.PostModel>? posts;
  
  void getData() async {
    posts = await posts_repository.getPosts();
    setState(() {});
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: const AddBtnWidget(path: 'addPost'),
      body: RefreshIndicator(
        onRefresh: () async {
          return getData();
        },
        child: ListView(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset('assets/images/back_button_green.png', width: 50),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('ИНТЕРЕСНЫЕ ПОСТЫ', style: theme.textTheme.headlineMedium)
                      )
                    ],
                  )
                )
              ),
            ),
            Expanded(
              flex: 9,
              child: posts == null ?
                const Center(child: CircularProgressIndicator()) :
                Builder(builder: (BuildContext context) {
                  final List<PostWidget> children = [];
                  posts?.forEach((model.PostModel post) {
                    children.add(PostWidget(post: post));
                  });
                  return Selection(children: children);
                })
            )
          ],
        ),
      )
    );
  }
}