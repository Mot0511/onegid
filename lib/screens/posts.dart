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
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(image: AssetImage('assets/images/top_img.png'))
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 30, top: 70),
                child: Text('ИНТЕРЕСНЫЕ\nПОСТЫ', style: TextStyle(fontSize: 35, color: Colors.black87))
              )
            ),
          ),
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future: posts,
              builder: (BuildContext context, AsyncSnapshot snap) {
                final Widget widget;
                if (snap.hasData) {
                  final data = snap.data;
                  List<Widget> lColumn = [];
                  List<Widget> rColumn = [];
                  for (var i = 0; i < data.length; i++) {
                    if (i % 2 == 0){
                      lColumn.add(Post(post: data[i]));
                    } else {
                      rColumn.add(Post(post: data[i]));
                    }
                  }
                  widget = Row(
                    children: [
                      Column(
                        children: lColumn,
                      ),
                      Column(
                        children: rColumn,
                      )
                    ],
                  );
                  // children.add(Wrap(children: widgets));
                } else if (snap.hasError) {
                  widget = Text('${snap.error}');
                } else {
                  widget = Center(child: CircularProgressIndicator());
                }
                return ListView(children: [widget]);
              },
            )
          )
        ],
      ),
    );
  }
}