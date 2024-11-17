import 'package:flutter/material.dart';
import 'package:onegid/components/bottomNav.dart';
import 'package:onegid/components/menu.dart';
import 'package:onegid/screens/map.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Text('Last posts')
          ),
          Expanded(
            flex: 3,
            child: Text('Ad')
          ),
          Expanded(
            flex: 3,
            child: Menu()
          ),
          Expanded(
            flex: 2,
            child: BottomNav()
          )
        ],
      ),
    );
  }
}


