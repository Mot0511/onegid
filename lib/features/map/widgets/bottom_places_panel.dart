import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/map/map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomPlacesPanel extends StatelessWidget {
  const BottomPlacesPanel({super.key, required this.panelController, required this.choosenPlaces, required this.clearPlaces});
  final PanelController panelController;
  final List<Place> choosenPlaces;
  final clearPlaces;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SlidingUpPanel(
      controller: panelController,
      panel: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: clearPlaces,
                  child: Text('Стереть ❌', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context, choosenPlaces),
                  child: Text('Создать маршрут ✅', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.green)),
                )
              ],
            ),
            SizedBox(height: 20),
            ...List.generate(choosenPlaces.length, (i) => 
              Flexible(child: Text('${i + 1}. ${choosenPlaces[i].title}', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)))
            )
          ],
        )
      )
    );
  }
}