import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/app.dart';
import 'package:onegid/features/auth/repositories/auth_repository.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(
    apiKey: "da3e48c8-a6ca-477f-88da-f4ef06e563ae"
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerSingleton(AuthRepository());
  GetIt.I.registerSingleton(PostsRepository());

  runApp(const OneGid());
}

