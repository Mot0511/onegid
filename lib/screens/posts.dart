import 'package:flutter/material.dart';
import 'package:onegid/models/Post.dart' as model;
import 'package:onegid/components/post.dart';
import 'package:onegid/services/fetchPosts.dart';

class Posts extends StatelessWidget{
  Posts({super.key});

  late final Future<List<model.Post>> posts = getPosts();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage('assets/images/add.png'))
        ),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/addPost')
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
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
                      child: Text('ИНТЕРЕСНЫЕ ПОСТЫ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                    )
                  ],
                )
              )
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: posts,
                builder: (BuildContext context, AsyncSnapshot snap) {
                  final List<Widget> children = [];
                  if (snap.hasData) {
                    final data = snap.data;
                    data.forEach((model.Post post) {
                      children.add(Post(post: post));
                    });
                  } else if (snap.hasError) {
                    children.add(Text('${snap.error}'));
                  } else {
                    children.add(Center(child: CircularProgressIndicator()));
                  }
                  return Wrap(children: children);
                },
              )
            )
          )
        ],
      ),
    );
  }
}