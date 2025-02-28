import 'package:equatable/equatable.dart';
import 'package:onegid/features/posts/models/category.dart';
import 'package:onegid/features/posts/models/models.dart';

abstract class PostsState extends Equatable {}

class PostsStateInitial extends PostsState {
  @override
  List get props => [];
}

class PostsStateLoading extends PostsState {
  @override
  List get props => [];
}

class PostsStateLoaded extends PostsState {
  final List<PostModel> posts;
  final List<Category> categories;

  PostsStateLoaded({required this.posts, required this.categories});

  @override
  List get props => [posts];
}

class PostsStateError extends PostsState {
  final Object? exception;

  PostsStateError({required this.exception});

  @override
  List get props => [exception];
}