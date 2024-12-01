import 'package:flutter/material.dart';
import 'package:onegid/screens/map.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context){
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green
              ),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Image.asset("assets/images/main_menu/$image", width: 50, height: 50),
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(title, style: const TextStyle(fontSize: 10, color: Colors.green))
            )
          ]
        ),
      ),
      onTap: () => Navigator.pushNamed(context, '/map', arguments: MapArguments(mode: MapMode.showPlaces, argument: title)),
    );
  }
}