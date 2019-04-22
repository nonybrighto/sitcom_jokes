import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_cast.dart';

part 'tmdb_movie_genre.g.dart';


abstract class TmdbMovieGenre implements Built<TmdbMovieGenre, TmdbMovieGenreBuilder> {


  static Serializer<TmdbMovieGenre> get serializer => _$tmdbMovieGenreSerializer;


  int get id;
  String get name;


  factory TmdbMovieGenre([updates(TmdbMovieGenreBuilder b)]) = _$TmdbMovieGenre;

  TmdbMovieGenre._();

}