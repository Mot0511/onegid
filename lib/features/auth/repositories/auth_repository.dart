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

  Future<Account> getAccount(String email) async {
    final snap = await db.collection('users').doc(email).get();
    final userdata = snap.data();

    if (userdata?.containsKey('region') == null) {
      userdata?['region'] = 'Киров (Кировская область)';
    }

    return Account(login: userdata?['nickname'], email: email, region: userdata?['region']);
  }

  Future<Account?> signinWithGoogle() async {
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

    if (email != null) {
      await setPrefs('login', email.split('@')[0]);
      final Account account = await getAccount(email);
      return account;
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

    final Account account = await getAccount(email);
    await setPrefs('login', account.login);

    return account;
  }

  Future<Account> signup(String login, String email, String password) async {
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
  
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Этот пользователь уже существует');
      }
    } catch (e) {
      print(e);
    }

    final Account account = await getAccount(email);
    await setPrefs('login', account.login);

    return account;
  }

}