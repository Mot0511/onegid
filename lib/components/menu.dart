import 'package:flutter/material.dart';
import 'package:onegid/components/menuItem.dart';

class Menu extends StatelessWidget{
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                MenuItem(title: 'Отели', image: 'menuItems/hotel.png'),
                MenuItem(title: 'Кафе', image: 'menuItems/restaurant.png'),
                MenuItem(title: 'Аптеки', image: 'menuItems/apt.png'),
                MenuItem(title: 'Кофейни', image: 'menuItems/cofe.png'),
              ]
            ),
            Row(
              children: [
                MenuItem(title: 'Театры', image: 'menuItems/theatre.png'),
                MenuItem(title: 'Банки', image: 'menuItems/bank.png'),
                MenuItem(title: 'Развлечения', image: 'menuItems/entertainment.png'),
                MenuItem(title: 'Парки', image: 'menuItems/park.png'),
              ]
            )
          ],
        )
      );
  }
}

