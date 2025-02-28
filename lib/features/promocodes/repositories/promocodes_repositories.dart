import 'package:get_it/get_it.dart';
import 'package:onegid/features/auth/bloc/bloc.dart';
import 'package:onegid/features/auth/bloc/states.dart';
import 'package:onegid/features/promocodes/promocodes.dart';
import 'package:onegid/repositories/base_repository.dart';

class PromocodesRepository extends FirebaseRepository {

  final UserBloc userBloc = GetIt.I<UserBloc>();

  Future<List<Promocode>?> getPromocodes() async {
    if (userBloc.state is UserStateLoaded) {
      final List? promoIds = (userBloc.state as UserStateLoaded).account.promocodes;
      final List<Promocode> promocodes = [];
      
      if (promoIds != null) {
        for (var promoId in promoIds) {
          final snap = await db.collection('promocodes').doc(promoId).get();
          final doc = snap.data();
          promocodes.add(Promocode(name: doc?['name'], title: doc?['title'], description: doc?['description'], code: doc?['code']));
        }
      }
      return promocodes;
    }
  }
}