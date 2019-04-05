import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/list_response.dart';
import 'package:built_value/built_value.dart';
import 'package:sitcom_joke/models/user.dart';

import 'serializers.dart';

part 'user_list_response.g.dart'; 


abstract class UserListResponse  implements Built<UserListResponse, UserListResponseBuilder>, ListResponse<User> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<UserListResponse> get serializer => _$userListResponseSerializer;

  int get totalPages;
  int get perPage;
  int get currentPage;
  BuiltList<User> get results;

  factory UserListResponse([updates(UserListResponseBuilder b)]) = _$UserListResponse;
  UserListResponse._();

  factory UserListResponse.fromJson(Map<String, dynamic> json){

    UserListResponse userListResponse = standardSerializers.deserializeWith(UserListResponse.serializer, json);
    return userListResponse;
  }

}