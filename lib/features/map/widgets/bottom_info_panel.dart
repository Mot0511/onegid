import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/map/map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomInfoPanel extends StatelessWidget {
  BottomInfoPanel({super.key, required this.panelController, required this.choosenPlace});
  final PanelController panelController;
  final Place? choosenPlace;

  final UserBloc userBloc = GetIt.I<UserBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SlidingUpPanel(
      controller: panelController,
      panel: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(choosenPlace!.title, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.black))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 40),
                  onPressed: () => panelController.close(),
                ),
                BlocBuilder<UserBloc, UserState>(
                  bloc: userBloc,
                  builder: (context, state) {
                    if (state is UserStateLoaded) {
                      if (state.account.favPlaces.map((place) => place.title).toList().contains(choosenPlace!.title)) {
                        return GestureDetector(
                          onTap: () => userBloc.add(RemoveFavPlace(place: (choosenPlace as Place))),
                          child: Image.asset('assets/images/bottom_sheet/del_favorite.png', width: 80)
                        );
                      } else  {
                        return GestureDetector(
                          onTap: () => userBloc.add(AddFavPlace(newPlace: (choosenPlace as Place))),
                          child: Image.asset('assets/images/bottom_sheet/heart.png', width: 80)
                        );
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/reviews', arguments: choosenPlace),
                  child: Image.asset('assets/images/bottom_sheet/reviews.png', width: 90)
                )
              ],
            )
          ],
        ),
      )
    );
  }
}