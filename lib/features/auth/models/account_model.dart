import 'package:onegid/features/map/map.dart';
import 'package:onegid/features/promocodes/models/models.dart';

class Account {
  final String login;
  final String email;
  String region;
  List favPlaces;
  List? promocodes;

  Account({required this.login, required this.email, required this.region, required this.favPlaces, required this.promocodes});
}
