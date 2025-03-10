import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viralize/domain/usecases/add_post_usecase.dart';
import 'package:viralize/domain/usecases/get_posts_usecase.dart';
import 'package:viralize/presentation/home/bloc/post_event.dart';
import 'package:viralize/presentation/home/bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;
  final AddPostUseCase addPostUseCase;

  PostBloc({required this.getPostsUseCase, required this.addPostUseCase})
      : super(PostInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
    on<AddPostEvent>(_onAddPost);
  }

  Future<void> _onFetchPosts(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await getPostsUseCase();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError('Erro ao buscar posts'));
    }
  }

  Future<void> _onAddPost(AddPostEvent event, Emitter<PostState> emit) async {
    try {
      await addPostUseCase(event.post);
      final posts = await getPostsUseCase();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError('Erro ao adicionar post'));
    }
  }
}
