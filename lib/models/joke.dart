import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/movie/basic_movie_details.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/user.dart';

import 'serializers.dart';

part 'joke.g.dart'; 

enum JokeType{image, text}

enum JokeSortProperty{title, dataAdded, likes}


abstract class Joke implements Built<Joke, JokeBuilder> {
  /// Example of how to make a built_value type serializable.
  ///
  /// Declare a static final [Serializer] field called `serializer`.
  /// The built_value code generator will provide the implementation. You need
  /// to do this for every type you want to serialize.
  static Serializer<Joke> get serializer => _$jokeSerializer;

  String get id;
  String get title;
  String get content;
  int get commentCount;
  //@BuiltValueField(wireName: 'joke_type')
  JokeType get jokeType;
  @nullable
  DateTime get dateAdded;
  @nullable
  int get likeCount;
  bool get liked;
  bool get favorited;
  @nullable
  BasicMovieDetails get movie;
  @nullable 
  User get owner;

  factory Joke([updates(JokeBuilder b)]) = _$Joke;
  Joke._();


  factory Joke.fromJson(Map<String, dynamic> json){

    Joke joke = standardSerializers.deserializeWith(Joke.serializer, json);
    return joke;
  }

  Movie getMovie(){
    BasicMovieDetailsBuilder builder = movie.toBuilder();
    return Movie((b) => b.basicDetails = builder );
  }

}