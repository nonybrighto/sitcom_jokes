import 'dart:convert';

import 'package:sitcom_joke/models/joke.dart';
import 'package:test/test.dart';

main() {
  test('Check if two objects with same values are equal', () {
    Joke firstJoke = Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..content = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..profileIconUrl = 'the_url'));

    Joke secondJoke = Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..content = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..profileIconUrl = 'the_url'));
    
    expect(firstJoke, secondJoke);
    expect(true, firstJoke == secondJoke);
  });

  test('Convert json to joke object', () {
   
   String jokeJson = '''{
    "likeCount": 0,
    "commentCount": 0,
    "id": "55fb43e1-9b5d-5f47-ae5e-99d034437ae1",
    "title": "This is a fresh joke sssa ddd this s",
    "dateAdded": "2019-04-04 15:39:58",
    "content": "anoxxx xxther joke is the text ss  s sdddddd eeess rrrrresdd",
    "liked": false,
    "favorited": false,
    "jokeType": "text",
    "owner": {
        "photoUrl": "https://lh3.googleusercontent.com/-7pX2KjlP-14/AAAAAAAAAAI/AAAAAAAAABQ/oylyelUx3Nw/s96-c/photo.jpg",
        "id": "bd19684f-6e1d-57c2-b612-1d03fd1d8227",
        "username": "nony"
    },
    "movie": {
        "description": "the movie description",
        "tmdbMovieId": 1,
        "id": "abcde",
        "title": "movie title",
        "followed": false
    }
}''';

Joke convertedJoke =Joke.fromJson(json.decode(jokeJson));
    expect(convertedJoke.id, '55fb43e1-9b5d-5f47-ae5e-99d034437ae1');
  });
}
