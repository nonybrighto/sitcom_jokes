import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/comment_list_response.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/movie_list_response.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_cast.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_credit.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/models/user_list_response.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Movie,
  Joke,
  User,
  Comment,
  MovieListResponse,
  JokeListResponse,
  UserListResponse,
  CommentListResponse,
  TmdbMovieDetails,
  TmdbMovieCredit,
  TmdbMovieCast,
])

final Serializers serializers = _$serializers;
final Serializers standardSerializers = (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())..add(Iso8601DateTimeSerializer())).build();