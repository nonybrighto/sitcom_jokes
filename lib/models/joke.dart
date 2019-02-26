import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/movie.dart';
import 'package:built_value/built_value.dart';
import 'package:sitcom_joke/utils/enum_string_util.dart';
import 'dart:convert' as json;

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
  //@BuiltValueField(wireName: 'joke_type')
  JokeType get jokeType;
  @nullable
  DateTime get dateAdded;
  @nullable
  int get likes;
  @nullable
  Movie get movie;

  factory Joke([updates(JokeBuilder b)]) = _$Joke;
  Joke._();


  factory Joke.fromJson(String jsonString){

    final parsed = json.jsonDecode(jsonString);
    Joke joke = standardSerializers.deserializeWith(Joke.serializer, parsed);
    return joke;
  }

}

// class Joke{

//     final String id;
//     final JokeType jokeType;
//     final String title;
//     final String content;
//     final DateTime dateAdded;
//     final int likes;
//     final Movie movie;

//     Joke({this.id, this.jokeType, this.title, this.content, this.dateAdded, this.likes, this.movie});


//     factory Joke.fromJson(String jsonString){

//         return Joke();
//     }

//     String  toJSon(){
      
//           return 'dddddd';
//     }
// }