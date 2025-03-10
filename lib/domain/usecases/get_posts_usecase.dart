import 'package:viralize/domain/entities/post_entity.dart';
import 'package:viralize/domain/repository/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call() async {
    return await repository.getPosts();
  }
}
