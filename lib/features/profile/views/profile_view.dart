import 'package:flutter/material.dart';
import 'package:onegid/features/profile/widgets/appbar_widget.dart';
import 'package:onegid/utils/prefs.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

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
            child: Column(
              children: [
                Image.asset('assets/images/profile_image.png', width: 100, height: 100),
                SizedBox(height: 20),
                Text(login, style: theme.textTheme.titleLarge),
                SizedBox(height: 5),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Выйти из аккаунта', style: theme.textTheme.titleMedium)
                  ),
                  onTap: () => signout(context)
                )
              ],
            )
          ),
        ],
      )
    );
  }
}