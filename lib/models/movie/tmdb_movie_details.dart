import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_credit.dart';

import '../serializers.dart';

part 'tmdb_movie_details.g.dart';


abstract class TmdbMovieDetails implements Built<TmdbMovieDetails, TmdbMovieDetailsBuilder> {
 

  static Serializer<TmdbMovieDetails> get serializer => _$tmdbMovieDetailsSerializer;

  int get id;
  String get title;
  @BuiltValueField(wireName: 'backdrop_path')
  String get backdropPath;
  String get overview;
  @BuiltValueField(wireName: 'release_date')
  DateTime get releaseDate;
  @BuiltValueField(wireName: 'vote_average')
  double get voteAverage;
  @nullable
  TmdbMovieCredit get credits;



  factory TmdbMovieDetails([updates(TmdbMovieDetailsBuilder b)]) = _$TmdbMovieDetails;
  TmdbMovieDetails._();


  factory TmdbMovieDetails.fromJson(String jsonString){

    final parsed = json.jsonDecode(jsonString);
    TmdbMovieDetails movieDetails = standardSerializers.deserializeWith(TmdbMovieDetails.serializer, parsed);
    return movieDetails;
  }

}