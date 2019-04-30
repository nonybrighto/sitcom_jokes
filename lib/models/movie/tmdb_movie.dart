import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_credit.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_genre.dart';

import '../serializers.dart';

part 'tmdb_movie.g.dart';


abstract class TmdbMovie implements Built<TmdbMovie, TmdbMovieBuilder> {
 

  static Serializer<TmdbMovie> get serializer => _$tmdbMovieSerializer;

  int get id;
  String get name;
  @nullable
  @BuiltValueField(wireName: 'backdrop_path')
  String get backdropPath;
  String get overview;
  @BuiltValueField(wireName: 'first_air_date')
  DateTime get firstAirDate;
  @nullable
  @BuiltValueField(wireName: 'last_air_date')
  DateTime get lastAirDate;
  @BuiltValueField(wireName: 'vote_average')
  double get voteAverage;
  @nullable
  @BuiltValueField(wireName: 'number_of_seasons')
  int get numberOfSeasons;

  @nullable
  BuiltList<TmdbMovieGenre> get genres;
  @nullable
  TmdbMovieCredit get credits;



  factory TmdbMovie([updates(TmdbMovieBuilder b)]) = _$TmdbMovie;
  TmdbMovie._();


  factory TmdbMovie.fromJson(Map<String, dynamic> json){

    TmdbMovie movieDetails = standardSerializers.deserializeWith(TmdbMovie.serializer, json);
    return movieDetails;
  }


  String getBackdropUrl(){

    return kTmdbImageUrl+'w780'+backdropPath;
  }

  String getGenreCsv(){

    return (genres != null)?genres.map((g) => g.name).join(', '): 'N/A';
  }

}