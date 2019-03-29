import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/constants/constants.dart';

class JokeService {
  final String jokeUrl = kAppApihost + '/jokes/';

  Future<List<Joke>> fetchAllJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {
    await Future.delayed(Duration(seconds: 4));

    String content;
    if (jokeType == JokeType.image) {
      content =
          'https://images.pexels.com/photos/1151262/pexels-photo-1151262.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
    } else {
      content = 'this is the stupid joke that i just added';
    }

    return List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id'
        ..title = 'title1'
        ..content = content
        ..totalComments = 21
        ..likes = 1
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
        ..id = 'id'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..totalComments = 21
        ..likes = 1
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
        ..id = 'id'
        ..title = 'movie joke $num'
        ..content = 'movie Joke'
        ..totalComments = 21
        ..likes = 1
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
          ..name = 'John $num'
          ..profileIconUrl = 'the_url')));
   
  }
}
