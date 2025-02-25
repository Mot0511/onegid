import 'package:onegid/features/map/map.dart';

class Account {
  final String login;
  final String email;
  String region;
  List<Place> favPlaces;

  Account({required this.login, required this.email, required this.region, required this.favPlaces});
}
