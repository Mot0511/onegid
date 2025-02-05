import 'package:flutter/material.dart';
import 'package:onegid/features/posts/posts.dart' as model;
import 'package:onegid/screens/Post.dart' as screen;

class Post extends StatelessWidget{
  const Post({super.key, required this.post});
  final model.PostModel post;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(bottom: 10, right: 10),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.green),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: post.image
          )
        ),
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen.Post(post: post))),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.black26
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: Text(post.title, style: TextStyle(color: Colors.white, fontSize: 18))
              )
            )
          )
        )
      )
    );
  }
}