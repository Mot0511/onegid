import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/auth/widgets/appbar_widget.dart';
import 'package:onegid/utils/prefs.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final UserBloc userBloc = GetIt.I<UserBloc>();

  void signout(BuildContext context) async {
    await removePrefs('login');
    Navigator.of(context).pushNamed('/signin');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        children: [
          AppBarWidget(),
          SizedBox(height: 20),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserStateLoaded) {
                  return Column(
                    children: [
                      Image.asset('assets/images/profile_image.png', width: 100, height: 100),
                      const SizedBox(height: 20),
                      Text(state.account.login, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 5),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('Выйти из аккаунта', style: theme.textTheme.titleMedium)
                        ),
                        onTap: () => signout(context)
                      )
                    ],
                  );
                } else if (state is UserStateError) {
                  Fluttertoast.showToast(msg: 'При загрузке данных пользователя произошла ошибка');
                }
                return const CircularProgressIndicator();
              },
            )
          ),
        ],
      )
    );
  }
}