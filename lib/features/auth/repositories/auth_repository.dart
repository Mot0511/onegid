import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onegid/features/auth/models/models.dart';
import 'package:onegid/repositories/base_repository.dart';
import 'package:onegid/utils/prefs.dart';

class AuthRepository extends FirebaseRepository {

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<AccountModel> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await auth.signInWithCredential(credential);
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

    return AccountModel(login: email?.split('@')[0] as String, email: email as String);
    
  }

  Future<AccountModel?> signin(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      db.collection('users').doc(email).get().then(((snap) async {
        final data = snap.data();
        await setPrefs('login', data!['nickname']);
        return AccountModel(login: data!['nickname'] as String, email: email);
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(msg: 'Неверная почта или пароль');
      }
    }

  }

  Future<AccountModel> signup(String login, String email, String password) async {
    try {
      final credential = auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final db = FirebaseFirestore.instance;
      db.collection('users').doc(email).set({
        'email': email,
        'nickname': login,
        'favPlaces': []
      });
      await setPrefs('login', login);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Этот пользователь уже существует');
      }
    } catch (e) {
      print(e);
    }

    return AccountModel(login: login, email: email);
  }

}