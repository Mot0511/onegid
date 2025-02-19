import 'dart:io';

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset('assets/images/back_button_green.png', width: 40, height: 40),
          ),
          Text('Профиль', style: theme.textTheme.headlineLarge),
          GestureDetector(
            onTap: () => exit(0),
            child: Image.asset('assets/images/quit_button.png', width: 40, height: 40)
          )
        ],
      )
      )
    );
  }
}