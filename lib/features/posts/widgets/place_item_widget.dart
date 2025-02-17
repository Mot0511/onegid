import 'package:flutter/material.dart';
import 'package:onegid/features/map/map.dart';


class PlaceItem extends StatelessWidget{
  const PlaceItem({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: const Color.fromARGB(255, 40, 96, 42)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.green
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 9,
              child: Text(place.title, style: TextStyle(fontSize: 30, color: Colors.white))
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/map', arguments: MapArguments(mode: MapMode.showPlace, argument: place)),
                child: Image.asset('assets/images/placesdescbtn.png'),
              )
            )
          ],
        )
      )
    );
  }
}