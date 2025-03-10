import 'package:viralize/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
  Future<void> addPost(PostEntity post);
}
