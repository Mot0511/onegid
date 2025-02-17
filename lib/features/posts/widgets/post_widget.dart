import 'package:flutter/material.dart';
import 'package:onegid/features/posts/posts.dart' as model;
import 'package:onegid/features/posts/views/views.dart' as screen;

class PostWidget extends StatelessWidget{
  const PostWidget({super.key, required this.post});
  final model.PostModel post;

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: theme.primaryColor),
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
              padding: const EdgeInsets.only(bottom: 10, left: 10),
              child: Text(post.title, style: const TextStyle(color: Colors.white, fontSize: 18))
            )
          )
        )
      ),
    );
  }
}