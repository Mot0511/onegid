import 'package:flutter/material.dart';

class AddPost extends StatefulWidget{
  const AddPost({super.key});

  State<AddPost> createState() => _AddPost();
}

class _AddPost extends State<AddPost>{
  _AddPost(); 

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Heading(text: 'Добавьте фотографию'),
            Heading(text: 'Дайте название посту'),
            Heading(text: 'Выберите категорию поста'),
            Heading(text: 'О чем вы хотите рассказать'),
            Heading(text: 'Добавьте связанные места'),
            Heading(text: 'Аудиогид'),
          ]
        ),
      ),
    );
  }
}

class Heading extends StatelessWidget{
  const Heading({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500))
    );
  }
}