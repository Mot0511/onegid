import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/app.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/repositories/auth_repository.dart';
import 'package:onegid/features/posts/bloc/bloc.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';
import 'package:onegid/features/promocodes/bloc/bloc.dart';
import 'package:onegid/features/promocodes/repositories/promocodes_repositories.dart';
import 'package:onegid/themes/provider.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(
    apiKey: "da3e48c8-a6ca-477f-88da-f4ef06e563ae"
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerSingleton(AuthRepository());
  GetIt.I.registerSingleton(UserBloc(authRepository: GetIt.I<AuthRepository>()));
  GetIt.I.registerSingleton(PostsRepository());
  GetIt.I.registerSingleton(PromocodesRepository());
  GetIt.I.registerSingleton(PostsBloc(postsRepository: GetIt.I<PostsRepository>()));
  GetIt.I.registerSingleton(PromocodesBloc(promocodesRepository: GetIt.I<PromocodesRepository>()));

  // final talker = TalkerFlutter.init();
  // GetIt.I.registerSingleton(talker);
  // GetIt.I<Talker>().info('Talker was initialized');

  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (context) => ThemeProvider(),
    builder: (context, child) => OneGid(),
  )
  );
}

