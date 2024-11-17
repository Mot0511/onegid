import 'package:flutter/material.dart';
import 'package:onegid/components/item.dart';

class Menu extends StatelessWidget{
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                MenuItem(title: 'Item 1'),
                MenuItem(title: 'Item 2'),
                MenuItem(title: 'Item 3'),
                MenuItem(title: 'Item 4'),
              ]
            ),
            Row(
              children: [
                MenuItem(title: 'Item 5'),
                MenuItem(title: 'Item 6'),
                MenuItem(title: 'Item 7'),
                MenuItem(title: 'Item 8'),
              ]
            )
          ],
        )
      )
    );
  }
}

