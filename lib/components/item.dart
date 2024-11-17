import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 25,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset("assets/menuItem.png", width: 50, height: 50),
            Text(title)
          ]
        )
      )
    );
  }
}