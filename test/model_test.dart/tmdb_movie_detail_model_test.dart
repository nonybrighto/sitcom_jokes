import 'dart:convert' as json;

import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_cast.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';
import 'package:test/test.dart';

void main(){

test('can deserialize tmdb movie details', (){

    String tmdbJson = ''' {
      "id": 550,
      "title":"Fight Club",
      "overview":"overview",
      "release_date":"1999-10-15",
      "vote_average":8.4,
      "backdrop_path"	: "/52AfXWuXCHn3UjD17rBruA9f5qb.jpg",
      "credits":{
        "cast":[
          {"cast_id":4,"character":"The Narrator","credit_id":"52fe4250c3a36847f80149f3","gender":2,"id":819,"name":"Edward Norton","order":0,"profile_path":"/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"}
        ]
      } 
    } ''';

    TmdbMovieDetails movieDetailsFromJson =TmdbMovieDetails.fromJson(json.jsonDecode(tmdbJson));
   
    TmdbMovieDetails movieDetails =TmdbMovieDetails((b) => b
      ..id=550
      ..title='Fight Club'
      ..backdropPath='/52AfXWuXCHn3UjD17rBruA9f5qb.jpg'
      ..overview='overview'
      ..releaseDate=DateTime(1999,10,15)
      ..voteAverage=8.4
      ..credits.cast = BuiltList<TmdbMovieCast>([
          TmdbMovieCast((b) => b
          ..castId=4
          ..character='The narrator'
          ..id=819
          ..name='name'
          ..profilePath ='/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg'
          )
      ]).toBuilder()
    );

    expect(movieDetailsFromJson.id, 550);
    expect(movieDetailsFromJson.credits.cast.first.castId, 4);

    expect(movieDetailsFromJson.id, movieDetails.id);


   // expect(Joke.fromJson(jokeJson).jokeType, jokeObject.jokeType);

  });


 
}