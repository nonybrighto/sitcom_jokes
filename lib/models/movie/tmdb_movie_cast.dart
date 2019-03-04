import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';


part 'tmdb_movie_cast.g.dart';


abstract class TmdbMovieCast implements Built<TmdbMovieCast, TmdbMovieCastBuilder> {


  static Serializer<TmdbMovieCast> get serializer => _$tmdbMovieCastSerializer;


  int get id;
  @BuiltValueField(wireName: 'cast_id')
  int get castId;
  String get character;
  String get name;
  @BuiltValueField(wireName: 'profile_path')
  String get profilePath;


  factory TmdbMovieCast([updates(TmdbMovieCastBuilder b)]) = _$TmdbMovieCast;

  TmdbMovieCast._();

}