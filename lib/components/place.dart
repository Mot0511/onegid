import 'package:flutter/material.dart';
import 'package:onegid/models/Place.dart';
import 'package:onegid/screens/map.dart';

class PlaceItem extends StatelessWidget{
  const PlaceItem({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 87, 175, 128)
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: Text(place.title, style: TextStyle(fontSize: 20, color: Colors.white))
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
      )
    );
  }
}