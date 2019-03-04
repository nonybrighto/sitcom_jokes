import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'tmdb_movie_details.g.dart';


abstract class TmdbMovieDetails implements Built<TmdbMovieDetails, TmdbMovieDetailsBuilder> {
 

  static Serializer<TmdbMovieDetails> get serializer => _$tmdbMovieDetailsSerializer;

  int get id;
  String get name;


  factory TmdbMovieDetails([updates(TmdbMovieDetailsBuilder b)]) = _$TmdbMovieDetails;
  TmdbMovieDetails._();


  factory TmdbMovieDetails.fromJson(String jsonString){

    final parsed = json.jsonDecode(jsonString);
    TmdbMovieDetails movieDetails = standardSerializers.deserializeWith(TmdbMovieDetails.serializer, parsed);
    return movieDetails;
  }

}