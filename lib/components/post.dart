import 'package:flutter/material.dart';
import 'package:onegid/models/Post.dart' as model;
import 'package:onegid/screens/Post.dart' as screen;

class Post extends StatelessWidget{
  const Post({super.key, required this.post});
  final model.Post post;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: post.image
          )
        ),
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen.Post(post: post))),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15, left: 6),
              child: Text(post.title, style: TextStyle(color: Colors.white, fontSize: 18))
            )
          )
        )
      ),
    );
  }
}