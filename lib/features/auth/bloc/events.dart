import 'package:equatable/equatable.dart';
import 'package:onegid/features/map/map.dart';

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

class AddFavPlace extends UserEvent {
  final Place newPlace;

  AddFavPlace({required this.newPlace});

  @override
  List get props => [newPlace];
}

class RemoveFavPlace extends UserEvent {
  final Place place;

  RemoveFavPlace({required this.place});

  @override
  List get props => [place];
}