import 'dart:convert' as json;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_credit.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_genre.dart';

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
  BuiltList<TmdbMovieGenre> get genres;
  @nullable
  TmdbMovieCredit get credits;



  factory TmdbMovieDetails([updates(TmdbMovieDetailsBuilder b)]) = _$TmdbMovieDetails;
  TmdbMovieDetails._();


  factory TmdbMovieDetails.fromJson(Map<String, dynamic> json){

    TmdbMovieDetails movieDetails = standardSerializers.deserializeWith(TmdbMovieDetails.serializer, json);
    return movieDetails;
  }


  String getBackdropUrl(){

    return kTmdbImageUrl+'w780'+backdropPath;
  }

  String getGenreCsv(){

    return (genres != null)?genres.map((g) => g.name).join(', '): 'N/A';
  }

}