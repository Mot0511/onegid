import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onegid/components/place.dart';
import 'package:onegid/models/Place.dart';
import 'package:onegid/models/Post.dart';
import 'dart:io';
import 'package:onegid/screens/map.dart';
import 'package:onegid/services/fetchPosts.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as mapkit;
import 'package:yandex_maps_mapkit/places.dart';

class AddPost extends StatefulWidget{
  const AddPost({super.key});

  State<AddPost> createState() => _AddPost();
}

class _AddPost extends State<AddPost>{
  _AddPost();

  String selectedCat = 'Нет';
  var imagePreview;
  List<Place> choosenPlaces = [];

  late final TextEditingController title = TextEditingController(text: '');
  late final TextEditingController description = TextEditingController(text: '');

  void pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? ximage = await picker.pickImage(source: ImageSource.gallery);
    if (ximage != null){
      File image = File(ximage!.path);
      setState(() {
        imagePreview = image;
      });
    }
  }

  void choosePlaces(BuildContext context) async {
    final places = (await Navigator.pushNamed(context, '/map', arguments: MapArguments(mode: MapMode.choosePlaces)) as List<dynamic>);
    setState(() {
      choosenPlaces = (places as List<Place>);
    });
  }

  void addPost_() async {
    final Post post = Post(
      title: title.text, 
      description: description.text,
      author: (await getPrefs('login') as String),
      places: choosenPlaces, 
      cat: selectedCat,
      image: imagePreview
    );

    addPost(post);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 50,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset('assets/images/back_button_green.png', width: 50),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Создать пост', style: TextStyle(fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold))
                    )
                  ],
                )
              ),
            ),
            Field(
              heading: 'Добавьте фотографию',
              widget: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: pickImage,
                    child: imagePreview == null ? Image.asset('assets/images/choose_photo.png', width: 200, height: 200) : Image.file(imagePreview),
                  )
                )
              ),
            ),
            Field(
              heading: 'Дайте название посту',
              widget: TextFormField(
                controller: title,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Название (не больше 30 символов)'
                ),
              ),
            ),
            // Field(
            //   heading: 'Выберите категорию поста',
            //   widget: DropdownButton(
            //     menuWidth: 500,
            //     value: selectedCat,
            //     onChanged: (value) {
            //       setState(() {
            //         selectedCat = (value as String);
            //       });
            //     },
            //     items: [
            //       DropdownMenuItem(child: Text('Нет'), value: 'Нет'),
            //       DropdownMenuItem(child: Text('Мультипост'), value: 'Мультипост'),
            //       DropdownMenuItem(child: Text('Кафе и еда'), value: 'Кафе и еда'),
            //       DropdownMenuItem(child: Text('Места отдыха'), value: 'Места отдыха'),
            //       DropdownMenuItem(child: Text('Развлечения'), value: 'Развлечения'),
            //       DropdownMenuItem(child: Text('Здоровье'), value: 'Здоровье'),
            //       DropdownMenuItem(child: Text('Отели'), value: 'Отели'),
            //     ]
            //   ),
            // ),         
            Field(
              heading: 'О чем вы хотите рассказать',
              widget: TextFormField(
                controller: description,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Описание поста'
                ),
              ),
            ),
            Field(
              heading: 'Добавьте связанные места',
              widget: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () => choosePlaces(context),
                        child: Image.asset('assets/images/mapadd_button.png', width: 100, height: 100),
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: List.generate(choosenPlaces.length, (i) => PlaceItem(place: choosenPlaces[i]))
                    )
                  )
                ],
              )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 34, 180, 115)),
                  foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () {
                  addPost_();
                  Navigator.of(context).pop();
                },
                child: Text('Создать пост'),
              )
            )
            // Heading(text: 'Аудиогид'),
          ]
        ),
      ),
    );
  }
}



class Field extends StatelessWidget{
  const Field({super.key, required this.heading, required this.widget});
  final String heading;
  final Widget widget;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Text(heading, textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500)),
            widget
          ],
        )
      )
    );
  }
}