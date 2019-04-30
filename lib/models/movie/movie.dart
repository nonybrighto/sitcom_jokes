import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie.dart';

import '../serializers.dart';
part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {


  static Serializer<Movie> get serializer => _$movieSerializer;

  String get id;
  String get name;
  int get tmdbMovieId;
  @nullable
  bool get followed;
  @nullable
  String get overview;
  @nullable
  String get posterPath;
  int get jokeCount;
  DateTime get firstAirDate;
  int get followerCount;
  @nullable
  TmdbMovie get tmdbDetails;

  factory Movie([updates(MovieBuilder b)]) = _$Movie;

  Movie._();

  factory Movie.fromJson(Map<String, dynamic> json){

    Movie movieListResponse = standardSerializers.deserializeWith(Movie.serializer, json);
    return movieListResponse;
  }

  String getPosterUrl(){
    return kTmdbImageUrl+'w185_and_h278_bestv2'+posterPath;
  }

  bool hasFullDetails(){
    return tmdbDetails != null;
  }

}