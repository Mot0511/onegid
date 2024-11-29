import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onegid/utils/prefs.dart';

class Signin extends StatelessWidget{
  Signin({super.key});

  late final TextEditingController email = TextEditingController(text: '');
  late final TextEditingController password = TextEditingController(text: '');

  void signin(context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      final db = FirebaseFirestore.instance;
      db.collection('users').doc(email.text).get().then(((snap) async {
        final data = snap.data();
        await setPrefs('login', data!['nickname']);
        Navigator.pushNamed(context, '/');
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(msg: 'Неверная почта или пароль');
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Добро пожаловать', style: TextStyle(fontSize: 40), textAlign: TextAlign.left)
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 10),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Почта'
                      ),
                    ),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Пароль'
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Text('Нет аккаунта?'),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/signup'), 
                              child: Text('Создать'),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 0, 0)),
                                foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                              )
                            ),
                          ],
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => signin(context),
                        child: Text('ВОЙТИ'),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 34, 180, 115)),
                          foregroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                        )
                      ),
                    )
                  ],
                )
              )
            )
          )
        ],
      )
    );
  }
}