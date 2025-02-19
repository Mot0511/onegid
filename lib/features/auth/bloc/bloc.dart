import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onegid/features/auth/auth.dart';
import 'package:onegid/features/auth/bloc/events.dart';
import 'package:onegid/features/auth/bloc/states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.authRepository) : super(UserStateInitial()) {
    on<LoadUser>((event, emit) async {
      try {
        if (state is! UserStateLoaded) {
          emit(UserStateLoading());
        }
        
        final account = await authRepository.getAccount(event.email);
        
        emit(UserStateLoaded(account: account));
      } on Exception catch (e) {
        emit(UserStateError(exception: e));
      }
    });
  }

  final AuthRepository authRepository;
}