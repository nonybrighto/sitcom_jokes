import 'dart:convert';

import 'package:sitcom_joke/models/joke.dart';
import 'package:test/test.dart';

main() {
  test('Check if two objects with same values are equal', () {
    Joke firstJoke = Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..text = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..photoUrl = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22));

    Joke secondJoke = Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..text = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..photoUrl = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22));
    
    expect(firstJoke, secondJoke);
    expect(true, firstJoke == secondJoke);
  });

  test('Convert json to joke object', () {

   
   String jokeJson = '''{
            "likeCount": 0,
            "id": "310e6f23-77c0-52c9-931d-801a3d7783f1",
            "title": "This a text joke 3",
            "content": "3 Lorem ipsum is a joke about the joke of all craps and i dont know Lorem ipsum is a joke about the joke of all craps and i dont know Lorem ipsum is a joke about the joke of all craps and i dont know 2",
            "dateAdded": "2019-04-05 17:00:57",
            "commentCount": 0,
            "liked": false,
            "favorited": false,
            "owner": {
                "photoUrl": "https://lh3.googleusercontent.com/-7pX2KjlP-14/AAAAAAAAAAI/AAAAAAAAABQ/oylyelUx3Nw/s96-c/photo.jpg",
                "id": "bd19684f-6e1d-57c2-b612-1d03fd1d8227",
                "username": "nony",
                "jokeCount": 55,
                "following": true,
                "followed": true,
                "followerCount":10,
                "followingCount":20
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
    expect(convertedJoke.id, '310e6f23-77c0-52c9-931d-801a3d7783f1');
  });
}
