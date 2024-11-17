import 'package:flutter/material.dart';
import 'package:onegid/components/item.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        MenuItem(title: ''),
        MenuItem(title: ''),
        MenuItem(title: ''),
      ],
    );
  }
}