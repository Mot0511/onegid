import 'package:flutter/material.dart';
import 'package:onegid/screens/map.dart';

class BottomMenuItem extends StatelessWidget {
  const BottomMenuItem({super.key, required this.image, required this.route});
  final String image;
  final String route;

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 25,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
          child: Image.asset("assets/images/$image", width: 50, height: 50),
          onTap: () => Navigator.pushNamed(context, route, arguments: MapArguments(mode: MapMode.classic)),
        )
      )
    );
  }
}