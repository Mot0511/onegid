import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {}

class LoadPosts extends PostsEvent {

  final Completer? completer;

  LoadPosts({this.completer});

  @override
  List get props => [];
}