import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class LoadUser extends UserEvent {

  final String email;

  LoadUser({required this.email});

  @override
  List get props => [];
}

class ChangeRegion extends UserEvent {
  final String newRegion;

  ChangeRegion({required this.newRegion});

  @override
  List get props => [];
}