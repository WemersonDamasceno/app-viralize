import 'package:viralize/data/models/post_mode.dart';

import '../../core/http_client/http_client.dart';

class PostRemoteDataSource {
  final IHttpClient client;

  PostRemoteDataSource({required this.client});

  Future<List<PostModel>> fetchPosts() async {
    final response = await client.get(
      url: 'https://jsonplaceholder.typicode.com/posts',
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.body;
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  Future<PostModel> addPost(PostModel post) async {
    final response = await client.post(
      url: 'https://jsonplaceholder.typicode.com/posts',
      body: post.toJson(),
    );

    if (response.statusCode == 201) {
      return PostModel.fromJson(response.body);
    } else {
      throw Exception('Erro ao adicionar post');
    }
  }
}
