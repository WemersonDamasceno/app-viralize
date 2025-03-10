import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:viralize/data/models/post_mode.dart';

class PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSource(this.client);

  Future<List<PostModel>> fetchPosts() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  Future<void> addPost(PostModel post) async {
    final response = await client.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao adicionar post');
    }
  }
}
