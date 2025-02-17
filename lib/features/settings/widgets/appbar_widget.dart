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
        children: [
          Expanded(
            flex: 1,
            child:  GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/images/back_button_green.png', width: 40, height: 40),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text('Настройки', style: theme.textTheme.headlineMedium, textAlign: TextAlign.center),
          )
        ],
      )
      )
    );
  }
}