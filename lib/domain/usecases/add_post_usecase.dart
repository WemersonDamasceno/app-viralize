import 'package:viralize/domain/entities/post_entity.dart';
import 'package:viralize/domain/repository/post_repository.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<void> call(PostEntity post) async {
    await repository.addPost(post);
  }
}
