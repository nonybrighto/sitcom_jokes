import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/basic_movie_details.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/utils/serializer/joke_type_serializer.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Movie,
  Joke,
  User,
  Comment,
  BasicMovieDetails,
  TmdbMovieDetails,
])

final Serializers serializers = _$serializers;
final Serializers standardSerializers = (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())..add(Iso8601DateTimeSerializer())..add(JokeTypeSerializer())).build();