import 'package:viralize/domain/entities/post_entity.dart';

abstract class PostEvent {}

class FetchPostsEvent extends PostEvent {}

class AddPostEvent extends PostEvent {
  final PostEntity post;
  AddPostEvent(this.post);
}
