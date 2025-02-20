import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/models/models.dart';
import 'package:onegid/repositories/base_repository.dart';
import 'package:onegid/utils/prefs.dart';

class AuthRepository extends FirebaseRepository {

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Account?> getAccount(String email) async {
    final snap = await db.collection('users').doc(email).get();
    final userdata = snap.data();

    if (userdata != null) {
      if (userdata.containsKey('region')) {
        userdata['region'] = 'Киров (Кировская область)';
      }
      return Account(
        login: userdata['nickname'], 
        email: email, 
        region: userdata['region']
      );
    }
  }

  Future<void> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await auth.signInWithCredential(credential);
    final email = userCredential.user?.email;

    final docRef =  db.collection('users').doc(email);
    final userdata = await docRef.get();
    if (userdata.data() == null) {
      docRef.set({
        'email': email,
        'nickname': email?.split('@')[0],
      });
    }

    if (email != null) {
      await setPrefs('email', email);
    } else {
      Fluttertoast.showToast(msg: 'Произошла ошибка');
    }
  }

  Future<Account?> signin(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(msg: 'Неверная почта или пароль');
      }
    }

    await setPrefs('email', email);
  }

  Future<void> signup(String login, String email, String password) async {
    try {
      final credential = auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      db.collection('users').doc(email).set({
        'email': email,
        'nickname': login,
        'favPlaces': []
      });
  
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Этот пользователь уже существует');
      }
    } catch (e) {
      print(e);
    }

    await setPrefs('email', email);
  }

}