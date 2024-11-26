import 'package:flutter/material.dart';
import 'package:onegid/screens/map.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 25,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset("assets/images/$image", width: 50, height: 50),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(title, style: const TextStyle(fontSize: 10))
              )
            ]
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/map', arguments: MapArguments(mode: MapMode.showPlaces, argument: title)),
      )
    );
  }
}

