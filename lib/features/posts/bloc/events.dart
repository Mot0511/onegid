import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {}

class LoadPosts extends PostsEvent {

  final Completer? completer;
  final String email;

  LoadPosts({this.completer, required this.email});

  @override
  List get props => [];
}