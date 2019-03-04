import 'package:built_value/built_value.dart';
import 'package:sitcom_joke/models/movie/basic_movie_details.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {

  @nullable
  BasicMovieDetails get basicDetails;
  @nullable
  TmdbMovieDetails get tmdbDetails;

  factory Movie([updates(MovieBuilder b)]) = _$Movie;

  Movie._();

  bool hasFullDetails(){
    return basicDetails != null && tmdbDetails != null;
  }

}