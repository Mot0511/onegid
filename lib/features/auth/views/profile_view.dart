import 'package:flutter/material.dart';
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

  final UserBloc userBloc = UserBloc(GetIt.I<AuthRepository>());

  String login = 'Mot0511';

  void getLogin() async {
    final login_ = await getPrefs('login');
    if (login_ != null){
      login = login_;
    }
    setState(() {});
  }

  void initState() {
    getLogin();
  }

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

            )
          ),
        ],
      )
    );
  }
}