import 'package:viralize/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  final int? idModel;
  final String titleModel;
  final String bodyModel;

  PostModel({
    this.idModel,
    required this.titleModel,
    required this.bodyModel,
  }) : super(id: idModel, title: titleModel, body: bodyModel);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      idModel: json['id'],
      titleModel: json['title'],
      bodyModel: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idModel,
      'title': titleModel,
      'body': bodyModel,
    };
  }
}
