import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/list_response.dart';

import 'serializers.dart';

part 'comment_list_response.g.dart'; 


abstract class CommentListResponse  implements Built<CommentListResponse, CommentListResponseBuilder>, ListResponse<Comment> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<CommentListResponse> get serializer => _$commentListResponseSerializer;

  int get totalPages;
  int get perPage;
  int get currentPage;
  BuiltList<Comment> get results;

  factory CommentListResponse([updates(CommentListResponseBuilder b)]) = _$CommentListResponse;
  CommentListResponse._();



  factory CommentListResponse.fromJson(Map<String, dynamic> json){

    CommentListResponse commentListResponse = standardSerializers.deserializeWith(CommentListResponse.serializer, json);
    return commentListResponse;
  }

}