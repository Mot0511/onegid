import 'package:equatable/equatable.dart';

abstract class PromocodesEvent extends Equatable {}

class LoadPromocodes extends PromocodesEvent {
  @override
  List get props => [];
}