import 'package:flutter/material.dart';
import 'package:onegid/features/posts/posts.dart';
import 'package:onegid/features/posts/models/models.dart' as models;

class Post extends StatelessWidget {
  const Post({super.key, required this.post});
  final models.PostModel post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    child: Text(post.title, style: theme.textTheme.headlineMedium)
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
              child: Text(post.title, style: theme.textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(post.description, style: theme.textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(post.author, style: theme.textTheme.titleSmall),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text('Связанные места', style: theme.textTheme.titleLarge),
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