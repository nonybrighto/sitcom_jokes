import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/comment_list_response.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/user.dart';

class JokeService {
  final String jokeUrl = kAppApiUrl + '/jokes/';

  Future<JokeListResponse> fetchAllJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {
    

    // Response response;
    // try{
    //   Dio dio = new Dio();
    //   response = await dio.get(jokeUrl);



    // } on DioError catch(error){
    //       throw Exception((error.response != null)?response.data['message']:'Error Connectiing to server');
    // }

List<Joke> jokeListGen = List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

      BuiltList<Joke> jokeList = BuiltList();
      var jokeBuilder = jokeList.toBuilder();
      jokeBuilder.addAll(jokeListGen);
      jokeList =jokeBuilder.build();
      return JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  jokeList.toBuilder());



  }

  Future<JokeListResponse> fetchUserFavJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page
  }) async{

      List<Joke> jokeListGen = List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

      BuiltList<Joke> jokeList = BuiltList();
      var jokeBuilder = jokeList.toBuilder();
      jokeBuilder.addAll(jokeListGen);
      jokeList =jokeBuilder.build();
      return JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  jokeList.toBuilder());

  }

  Future<JokeListResponse> fetchMovieJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      Movie movie,
      int page
  }) async{

      List<Joke> jokeListGen = List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

      BuiltList<Joke> jokeList = BuiltList();
      var jokeBuilder = jokeList.toBuilder();
      jokeBuilder.addAll(jokeListGen);
      jokeList =jokeBuilder.build();
      return JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  jokeList.toBuilder());

  }
  Future<JokeListResponse> fetchUserJokes({
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      User user,
      int page
  }) async{

      List<Joke> jokeListGen = List.generate(20, (num) => 
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

      BuiltList<Joke> jokeList = BuiltList();
      var jokeBuilder = jokeList.toBuilder();
      jokeBuilder.addAll(jokeListGen);
      jokeList =jokeBuilder.build();
      return JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  jokeList.toBuilder());
  }

  Future<CommentListResponse> getComments({String joke, int page}) async {


    var commentListGen =  List.generate(20, (num) => Comment((b) => b
        ..id = num.toString()
        ..content = 'content $num'
        ..dateAdded = DateTime(2000)
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..profileIconUrl = 'the_url')));

           BuiltList<Comment> commentList = BuiltList();
      var commentBuilder = commentList.toBuilder();
      commentBuilder.addAll(commentListGen);
      commentList =commentBuilder.build();
      return CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  commentList.toBuilder());
   
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
