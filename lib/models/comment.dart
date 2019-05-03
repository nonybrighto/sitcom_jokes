import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/user.dart';

import 'serializers.dart';

part 'comment.g.dart';

abstract class Comment implements Built<Comment, CommentBuilder> {
 
 
  static Serializer<Comment> get serializer => _$commentSerializer;

  String get id;
  String get content;
  @nullable
  User get owner;
  DateTime get dateAdded;

  factory Comment([updates(CommentBuilder b)]) = _$Comment;
  Comment._();


  factory Comment.fromJson(String jsonString){

    final parsed = json.jsonDecode(jsonString);
    Comment comment = standardSerializers.deserializeWith(Comment.serializer, parsed);
    return comment;
  }

}
