import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:viralize/domain/entities/post_entity.dart';
import 'package:viralize/presentation/home/bloc/post_bloc.dart';
import 'package:viralize/presentation/home/bloc/post_event.dart';
import 'package:viralize/presentation/home/bloc/post_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  late PostBloc postBloc;

  @override
  void initState() {
    super.initState();

    postBloc = GetIt.I.get<PostBloc>();
    postBloc.add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Column(
        children: [
          _buildForm(context),
          Expanded(child: _buildPostList()),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: bodyController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  bodyController.text.isNotEmpty) {
                final post = PostEntity(
                  title: titleController.text,
                  body: bodyController.text,
                );
                postBloc.add(AddPostEvent(post));
                titleController.clear();
                bodyController.clear();
              }
            },
            child: const Text('Adicionar Post'),
          ),
        ],
      ),
    );
  }

  Widget _buildPostList() {
    return BlocBuilder<PostBloc, PostState>(
      bloc: postBloc,
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        } else if (state is PostError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Nenhum post encontrado.'));
      },
    );
  }
}
