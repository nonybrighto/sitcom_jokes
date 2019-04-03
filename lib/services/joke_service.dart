import 'dart:io';

import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/user.dart';

class JokeService {
  final String jokeUrl = kAppApiUrl + '/jokes/';

  Future<List<Joke>> fetchAllJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {
    await Future.delayed(Duration(seconds: 2));

    String content;
    if (jokeType == JokeType.image) {
      content =
          'https://images.pexels.com/photos/1151262/pexels-photo-1151262.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
    } else {
      content = 'this is the stupid joke that i just added';
    }

    return List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'title$num'
        ..content = content
        ..totalComments = 21
        ..likes = 1
        ..isLiked = false
        ..isFavorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.name = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

  }

  Future<List<Joke>> fetchUserFavJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page
  }) async{

        return List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..totalComments = 21
        ..likes = 1
        ..isLiked = false
        ..isFavorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.name = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

  }

  Future<List<Joke>> fetchMovieJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      Movie movie,
      int page
  }) async{

      return List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'movie joke $num'
        ..content = 'movie Joke'
        ..totalComments = 21
        ..likes = 1
        ..isLiked = false
        ..isFavorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.name = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

  }
  Future<List<Joke>> fetchUserJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      User user,
      int page
  }) async{

      await Future.delayed(Duration(seconds: 2));
      return List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..content = 'user Joke'
        ..totalComments = 21
        ..likes = 1
        ..isLiked = false
        ..isFavorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.name = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

  }

  Future<List<Comment>> getComments({String joke, int page}) async {


    return List.generate(20, (num) => Comment((b) => b
        ..id = num.toString()
        ..content = 'content $num'
        ..dateAdded = DateTime(2000)
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..profileIconUrl = 'the_url')));
   
  }

  Future<Joke> addJoke({Joke joke, File imageToUpload}) async{

     return null;
  }

  Future<bool> likeJoke({Joke joke}) async{
        return true;
  }
  Future<bool> dislikeJoke({Joke joke}) async{
      return true;
  }
  Future<bool>  favoriteJoke({Joke joke}) async{
      return true;
  }
  Future<bool> unfavoriteJoke({Joke joke}) async{
      return true;
  }
}
