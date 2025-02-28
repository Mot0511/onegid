import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:onegid/features/promocodes/bloc/bloc.dart';
import 'package:onegid/features/promocodes/bloc/events.dart';
import 'package:onegid/features/promocodes/bloc/states.dart';
import 'package:onegid/features/promocodes/promocodes.dart';
import 'package:onegid/features/promocodes/widgets/promocode_widget.dart';

class PromocodesView extends StatefulWidget {
  PromocodesView({super.key});

  @override
  State<PromocodesView> createState() => _PromocodesViewState();
}

class _PromocodesViewState extends State<PromocodesView> {
  final PromocodesBloc promocodesBloc = GetIt.I<PromocodesBloc>();

  @override
  void initState() {
    promocodesBloc.add(LoadPromocodes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          const AppBarWidget(),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<PromocodesBloc, PromocodesState>(
              bloc: promocodesBloc,
              builder: (context, state) {
                if (state is PromocodesStateLoaded && state.promocodes != null) {
                  final List<Widget> children = state.promocodes!.map((promo) => 
                    PromocodeWidget(
                      promocode: Promocode(name: promo.name, title: promo.title, description: promo.description, code: promo.code)
                    ),
                  ).toList();
                  return Row(children: children);
                } else if (state is PromocodesStateError) {
                  Fluttertoast.showToast(msg: 'При загрузке промокодов произошла ошибка');
                } 
                return const Center(child: CircularProgressIndicator());
              },
            )
          )
        ],
      ),
    );
  }
}