import 'package:equatable/equatable.dart';
import 'package:onegid/features/auth/auth.dart';

abstract class UserState extends Equatable {}

class UserStateInitial extends UserState {
  @override
  List get props => [];
}

class UserStateLoading extends UserState {
  @override
  List get props => [];
}

class UserStateLoaded extends UserState {
  final Account account;

  UserStateLoaded({required this.account});
  
  @override
  List get props => [account];
}

class UserStateError extends UserState {
  final Object exception;

  UserStateError({required this.exception});

  @override
  List get props => [exception];
}