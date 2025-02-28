import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onegid/features/promocodes/bloc/events.dart';
import 'package:onegid/features/promocodes/bloc/states.dart';
import 'package:onegid/features/promocodes/models/models.dart';
import 'package:onegid/features/promocodes/repositories/promocodes_repositories.dart';

class PromocodesBloc extends Bloc<PromocodesEvent, PromocodesState> {
  PromocodesBloc({required this.promocodesRepository}) : super(PromocodesStateInitial()) {
    on<PromocodesEvent>((event, emit) async {
      if (state is! PromocodesStateLoaded) {
        emit(PromocodesStateLoading());
      }

      try {
        final List<Promocode>? promocodes = await promocodesRepository.getPromocodes();
        if (promocodes != null) {
          emit(PromocodesStateLoaded(promocodes: promocodes));
        } else {
          emit(PromocodesStateLoaded());
        }
      } catch (e) {
        emit(PromocodesStateError(exception: e));
      }
      
    });
  }

  final PromocodesRepository promocodesRepository;
}