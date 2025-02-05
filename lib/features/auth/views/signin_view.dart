import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/models/account_model.dart';
import 'package:onegid/features/auth/repositories/auth_repository.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatelessWidget{
  Signin({super.key});

  late final TextEditingController email = TextEditingController(text: '');
  late final TextEditingController password = TextEditingController(text: '');

  final AuthRepository authRepository = GetIt.I<AuthRepository>();
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(20, 184, 147, 1), Color.fromRGBO(151, 221, 156, 1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight                    
          ),
        ),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70, left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Добро пожаловать', style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w800), textAlign: TextAlign.left)
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 10),
                  child: Column(
                    children: [
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: 'Почта'
                        ),
                      ),
                      TextField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: 'Пароль'
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              const Text('Нет аккаунта?'),
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
                          onPressed: () async {
                            AccountModel? account = await authRepository.signin(email.text, password.text);
                            Navigator.pushNamed(context, '/', arguments: account);
                          },
                          child: const Text('ВОЙТИ'),
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: InkWell(
                  onTap: () async {
                    AccountModel account = await authRepository.signinWithGoogle();
                    Navigator.pushNamed(context, '/', arguments: account);
                  },
                  child: Center(
                    child: Text('Войти через Google', style: TextStyle(fontSize: 20)),
                  ),
                )
              )
            )
          ],
        )
      )
    );
  }
}