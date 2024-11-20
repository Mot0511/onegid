import 'package:flutter/material.dart';
import 'package:onegid/components/bottomMenuItem.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        BottomMenuItem(image: 'bottomMenuItems/map.png', route: '/map'),
        BottomMenuItem(image: 'bottomMenuItems/posts.png', route: '/posts'),
        BottomMenuItem(image: 'bottomMenuItems/profile.png', route: '/profile'),
      ],
    );
  }
}