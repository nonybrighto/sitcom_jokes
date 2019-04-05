import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/list_response.dart';
import 'package:sitcom_joke/models/movie/basic_movie_details.dart';

import '../serializers.dart';

part 'basic_movie_details_list_response.g.dart'; 


abstract class BasicMovieDetailsListResponse  implements Built<BasicMovieDetailsListResponse, BasicMovieDetailsListResponseBuilder>, ListResponse<BasicMovieDetails> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<BasicMovieDetailsListResponse> get serializer => _$basicMovieDetailsListResponseSerializer;

  int get totalPages;
  int get perPage;
  int get currentPage;
  @nullable
  int get nextPage;
  @nullable
  int get previousPage;
  BuiltList<BasicMovieDetails> get results;

  factory BasicMovieDetailsListResponse([updates(BasicMovieDetailsListResponseBuilder b)]) = _$BasicMovieDetailsListResponse;
  BasicMovieDetailsListResponse._();

   factory BasicMovieDetailsListResponse.fromJson(Map<String, dynamic> json){

    BasicMovieDetailsListResponse basicMovieDetailsListResponse = standardSerializers.deserializeWith(BasicMovieDetailsListResponse.serializer, json);
    return basicMovieDetailsListResponse;
  }

}