import 'package:equatable/equatable.dart';
import 'package:onegid/features/promocodes/promocodes.dart';

abstract class PromocodesState extends Equatable {}

class PromocodesStateInitial extends PromocodesState {
  @override
  List get props => [];
}

class PromocodesStateLoading extends PromocodesState {
  @override
  List get props => [];
}

class PromocodesStateLoaded extends PromocodesState {

  final List<Promocode>? promocodes;

  PromocodesStateLoaded({this.promocodes});

  @override
  List get props => [promocodes];
}

class PromocodesStateError extends PromocodesState {
  final Object? exception;

  PromocodesStateError({required this.exception});
  
  @override
  List get props => [exception];
}