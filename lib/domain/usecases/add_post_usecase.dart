import 'package:viralize/domain/entities/post_entity.dart';
import 'package:viralize/domain/repository/post_repository.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<PostEntity> call(PostEntity post) async {
    return await repository.addPost(post);
  }
}
