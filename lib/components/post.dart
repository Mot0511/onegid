import 'package:flutter/material.dart';

class Post extends StatelessWidget{
  const Post({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/post.png')
            )
          ),
          child: InkWell(
            onTap: () => print(1),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15, left: 6),
                child: Text(title)
              )
            )
          )
        ),
      )
    );
  }
}