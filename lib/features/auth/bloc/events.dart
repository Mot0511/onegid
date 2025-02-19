import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {}

class LoadUser extends UserEvent {

  final String email;

  LoadUser({required this.email});

  @override
  List get props => [];
}