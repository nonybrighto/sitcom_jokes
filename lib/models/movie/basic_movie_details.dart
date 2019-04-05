import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';


import '../serializers.dart';

part 'basic_movie_details.g.dart';


abstract class BasicMovieDetails implements Built<BasicMovieDetails, BasicMovieDetailsBuilder> {
 

  static Serializer<BasicMovieDetails> get serializer => _$basicMovieDetailsSerializer;

  String get id;
  String get title;
  int get tmdbMovieId;
  @nullable
  bool get followed;
  @nullable
  String get description;

  factory BasicMovieDetails([updates(BasicMovieDetailsBuilder b)]) = _$BasicMovieDetails;
  BasicMovieDetails._();


  factory BasicMovieDetails.fromJson(String jsonString){

    final parsed = json.jsonDecode(jsonString);
    BasicMovieDetails movieDetails = standardSerializers.deserializeWith(BasicMovieDetails.serializer, parsed);
    return movieDetails;
  }

}

