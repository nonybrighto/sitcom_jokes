import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';

import '../serializers.dart';
part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {


  static Serializer<Movie> get serializer => _$movieSerializer;

  String get id;
  String get title;
  int get tmdbMovieId;
  @nullable
  bool get followed;
  @nullable
  String get description;
  @nullable
  String get posterUrl;
  int get jokeCount;
  DateTime get releaseDate;
  int get followerCount;
  @nullable
  TmdbMovieDetails get tmdbDetails;

  factory Movie([updates(MovieBuilder b)]) = _$Movie;

  Movie._();

  factory Movie.fromJson(Map<String, dynamic> json){

    Movie movieListResponse = standardSerializers.deserializeWith(Movie.serializer, json);
    return movieListResponse;
  }

  bool hasFullDetails(){
    return tmdbDetails != null;
  }

}