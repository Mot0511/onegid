import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatelessWidget{
  Signin({super.key});

  late final TextEditingController email = TextEditingController(text: '');
  late final TextEditingController password = TextEditingController(text: '');

  void signin(BuildContext context) async {
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

  void signinWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final email = userCredential.user?.email;

    final db = FirebaseFirestore.instance;
    final docRef =  db.collection('users').doc(email);
    final userdata = await docRef.get();
    if (userdata.data() == null) {
      docRef.set({
        'email': email,
        'nickname': email?.split('@')[0],
      });
    }

    await setPrefs('login', email?.split('@')[0]);
    Navigator.pushNamed(context, '/');
  }
 
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
                  onTap: () => signinWithGoogle(context),
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