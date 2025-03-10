import 'package:viralize/data/datasource/post_local_datasource.dart';
import 'package:viralize/data/datasource/post_remote_datasource.dart';
import 'package:viralize/data/models/post_mode.dart';
import 'package:viralize/domain/repository/post_repository.dart';

import '../../domain/entities/post_entity.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      final remotePosts = await remoteDataSource.fetchPosts();
      for (var post in remotePosts) {
        await localDataSource.insertPost(post); // Cache local
      }
      return remotePosts;
    } catch (e) {
      return await localDataSource.getPosts(); // Retorna cache se falhar
    }
  }

  @override
  Future<PostEntity> addPost(PostEntity post) async {
    final postModel = PostModel(
      idModel: post.id,
      titleModel: post.title,
      bodyModel: post.body,
    );
    final newPost = await remoteDataSource.addPost(postModel);

    await localDataSource.insertPost(newPost);

    return newPost;
  }
}
