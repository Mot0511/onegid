import 'package:flutter/material.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/posts/models/models.dart' as models;

class Post extends StatelessWidget {
  const Post({super.key, required this.post});
  final models.PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('assets/images/back_button_green.png', width: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(post.title, style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold))
                  )
                ],
              )
            ),
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(post.title, style: TextStyle(fontSize: 35, color: Colors.green)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(post.description, style: TextStyle(fontSize: 25)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(post.author, style: TextStyle(fontSize: 15)),
              )
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text('Связанные места', style: TextStyle(fontSize: 35, color: Colors.green)),
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