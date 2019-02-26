import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart'; 
part 'movie.g.dart'; 

abstract class Movie implements Built<Movie, MovieBuilder> {
 
 
  static Serializer<Movie> get serializer => _$movieSerializer;

  String get id;
  String get name;
  @nullable
  String get description;

  factory Movie([updates(MovieBuilder b)]) = _$Movie;
  Movie._();
}

// class Movie{

//   String id;
//   String name;
//   String description;
//   int seasons;
//   int maxEpisodes;
//   DateTime dateStarted;
//   DateTime dateEnded;

//   Movie({this.id, this.name, this.description, this.seasons, this.maxEpisodes, this.dateStarted, this.dateEnded});
// }

