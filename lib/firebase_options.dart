// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCZw0vXiLj72dvEwOico2q79uug6SObSCQ',
    appId: '1:1075473189282:web:a6dac85f564fa53bf88afb',
    messagingSenderId: '1075473189282',
    projectId: 'polmaps-test',
    authDomain: 'polmaps-test.firebaseapp.com',
    storageBucket: 'polmaps-test.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcPBe5GI-FcCFSMMRSJn3DOoTY1rUfim4',
    appId: '1:1075473189282:android:3472fa8e97048836f88afb',
    messagingSenderId: '1075473189282',
    projectId: 'polmaps-test',
    storageBucket: 'polmaps-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0BsEooYBOp1pPy0yZgT7p6AJ-BuGUBw8',
    appId: '1:1075473189282:ios:c9d4d50c19e0dce0f88afb',
    messagingSenderId: '1075473189282',
    projectId: 'polmaps-test',
    storageBucket: 'polmaps-test.appspot.com',
    androidClientId: '1075473189282-1gouq7hc6q5t3a0rd3osi3claheehk0t.apps.googleusercontent.com',
    iosClientId: '1075473189282-2ee6jqf68skei3hjut23b85ksgp8r6h8.apps.googleusercontent.com',
    iosBundleId: 'ru.polbanki.onegid',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0BsEooYBOp1pPy0yZgT7p6AJ-BuGUBw8',
    appId: '1:1075473189282:ios:c9d4d50c19e0dce0f88afb',
    messagingSenderId: '1075473189282',
    projectId: 'polmaps-test',
    storageBucket: 'polmaps-test.appspot.com',
    androidClientId: '1075473189282-1gouq7hc6q5t3a0rd3osi3claheehk0t.apps.googleusercontent.com',
    iosClientId: '1075473189282-2ee6jqf68skei3hjut23b85ksgp8r6h8.apps.googleusercontent.com',
    iosBundleId: 'ru.polbanki.onegid',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZw0vXiLj72dvEwOico2q79uug6SObSCQ',
    appId: '1:1075473189282:web:31f426c3acbe072cf88afb',
    messagingSenderId: '1075473189282',
    projectId: 'polmaps-test',
    authDomain: 'polmaps-test.firebaseapp.com',
    storageBucket: 'polmaps-test.appspot.com',
  );

}