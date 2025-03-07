import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onegid/features/posts/bloc/events.dart';
import 'package:onegid/features/posts/bloc/states.dart';
import 'package:onegid/features/posts/models/category.dart';
import 'package:onegid/features/posts/models/models.dart';
import 'package:onegid/features/posts/repositories/posts_repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({required this.postsRepository}) : super(PostsStateInitial()) {
    on<LoadPosts>((event, emit) async {
      if (state is! PostsStateLoaded) {
        emit(PostsStateLoading());
      }
      try {
        final List<PostModel> posts = await postsRepository.getPosts(event.email);
        final List<Category> categories = await postsRepository.getCategories();
        emit(PostsStateLoaded(posts: posts, categories: categories));
      } catch (e) {
        emit(PostsStateError(exception: e));
      } finally  {
        event.completer?.complete();
      }
    });
  }

  final PostsRepository postsRepository;
}