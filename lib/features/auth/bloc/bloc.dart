import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.authRepository}) : super(UserStateInitial()) {
    on<LoadUser>((event, emit) async {
      try {
        if (state is! UserStateLoaded) {
          emit(UserStateLoading());
        }
        
        final account = await authRepository.getAccount(event.email);
        if (account != null) {
          emit(UserStateLoaded(account: account));
        }
      } on Exception catch (e) {
        emit(UserStateError(exception: e));
      }
    });

    on<ChangeRegion>((event, emit) async {
      if (state is UserStateLoaded) {
        final account = (state as UserStateLoaded).account;
        emit(UserStateInitial());
        account.region = event.newRegion;
        emit(UserStateLoaded(account: account));
        authRepository.changeRegion(account.email, event.newRegion);
      }
    });

    on<AddFavPlace>((event, emit) async {
      if (state is UserStateLoaded) {
        final account = (state as UserStateLoaded).account;
        emit(UserStateInitial());
        account.favPlaces.add(event.newPlace);
        emit(UserStateLoaded(account: account));
        await authRepository.addFavPlace(account.email, event.newPlace);
      }
    });

    on<RemoveFavPlace>((event, emit) async {
      if (state is UserStateLoaded) {
        final account = (state as UserStateLoaded).account;
        emit(UserStateInitial());
        account.favPlaces.remove(event.place);
        emit(UserStateLoaded(account: account));
        await authRepository.removeFavPlace(account.email, event.place);
      }
    });

  }

  final AuthRepository authRepository;
}