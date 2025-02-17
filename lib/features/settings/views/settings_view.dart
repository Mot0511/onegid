import 'package:flutter/material.dart';
import 'package:onegid/features/settings/settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
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
                      Switch(value: isDarkTheme, onChanged: (value) => setState(() => isDarkTheme = value))
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