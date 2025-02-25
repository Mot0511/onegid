import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/settings/settings.dart';
import 'package:onegid/themes/provider.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:provider/provider.dart';
import 'package:bloc/bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  final UserBloc userBloc = GetIt.I<UserBloc>();

  bool isDarkTheme = false;

  void setTheme(context) async {
    isDarkTheme = !isDarkTheme;
    setState(() => {});

    final theme = Provider.of<ThemeProvider>(context, listen: false);
    if (isDarkTheme){
      theme.mode = ThemeMode.dark;
      await setPrefs('theme', 'dark');
    } else {
      theme.mode = ThemeMode.light;
      await setPrefs('theme', 'light');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (themeProvider.mode == ThemeMode.dark) {
      isDarkTheme = true;
      setState(() => {});
    }
    final theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        children: [
          AppBarWidget(),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Тема', style: theme.textTheme.titleLarge),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Поменять тему', style: theme.textTheme.titleMedium),
                      Switch(value: isDarkTheme, onChanged: (value) => setTheme(context))
                    ],
                  )
                ),
                Text('Регион', style: theme.textTheme.titleLarge),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: BlocBuilder<UserBloc, UserState>(
                    bloc: userBloc,
                    builder: (context, state) {
                      if (state is UserStateLoaded) {
                        return DropdownButton(
                          value: state.account.region,
                          items: [
                            DropdownMenuItem(
                              child: Text('Киров (Кировская область)'),
                              value: 'Киров (Кировская область)',
                            ),
                            DropdownMenuItem(
                              child: Text('Казань (Татарстан)'),
                              value: 'Казань (Татарстан)',
                            ),
                            DropdownMenuItem(
                              child: Text('Чебоксары (Чувашия)'),
                              value: 'Чебоксары (Чувашия)',
                            ),
                            DropdownMenuItem(
                              child: Text('Москва (Московская область)'),
                              value: 'Москва (Московская область)',
                            )
                          ],
                          onChanged: (value) => userBloc.add(ChangeRegion(newRegion: (value as String))),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                      
                    }
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}