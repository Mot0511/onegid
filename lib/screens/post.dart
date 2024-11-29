import 'package:flutter/material.dart';
import 'package:onegid/components/place.dart';
import 'package:onegid/models/Post.dart' as model;

class Post extends StatelessWidget {
  const Post({super.key, required this.post});
  final model.Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
        child: ListView(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: post.image
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text(post.title, style: TextStyle(fontSize: 35)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(post.description, style: TextStyle(fontSize: 25)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text('Связанные места', style: TextStyle(fontSize: 35)),
            ),
            Column(
              children: List.generate(post.places.length, (i) => PlaceItem(place: post.places[i])),
            )
          ],
        )
      ),
    );
  }
}