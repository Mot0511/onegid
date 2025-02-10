import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/models/account_model.dart';
import 'package:onegid/features/auth/repositories/auth_repository.dart';
import 'package:onegid/utils/prefs.dart';

class Signup extends StatelessWidget{
  Signup({super.key});

  late final TextEditingController login = TextEditingController(text: '');
  late final TextEditingController email = TextEditingController(text: '');
  late final TextEditingController password = TextEditingController(text: '');

  final AuthRepository auth_repository = GetIt.I<AuthRepository>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(20, 184, 147, 1), Color.fromRGBO(151, 221, 156, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight                    
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 70, left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Создать\nаккаунт', style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w800), textAlign: TextAlign.left)
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 10),
                child: Column(
                  children: [
                    TextField(
                      controller: login,
                      decoration: InputDecoration(
                        hintText: 'Логин'
                      ),
                    ),
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
                            Text('Есть аккаунт?'),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/signin'), 
                              child: Text('ВОЙТИ'),
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
                        onPressed: () async {
                          AccountModel account = await auth_repository.signup(login.text, email.text, password.text);
                          Navigator.pushNamed(context, '/', arguments: account);
                        },
                        child: Text('Создать'),
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
          ],
        )
      )
    );
  }
}