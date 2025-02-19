import 'package:flutter/material.dart';
import 'package:onegid/features/settings/settings.dart';
import 'package:onegid/themes/provider.dart';
import 'package:onegid/utils/prefs.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

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
                )
              ],
            ),
          )
        ],
      )
    );
  }
}