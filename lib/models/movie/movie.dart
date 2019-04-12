import 'package:built_value/built_value.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {

  String get id;
  String get title;
  int get tmdbMovieId;
  @nullable
  bool get followed;
  @nullable
  String get description;
  @nullable
  TmdbMovieDetails get tmdbDetails;

  factory Movie([updates(MovieBuilder b)]) = _$Movie;

  Movie._();

  bool hasFullDetails(){
    return tmdbDetails != null;
  }

}