import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/comment_list_response.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/auth_header.dart';
import 'package:sitcom_joke/utils/enum_string_util.dart';

class JokeService {
  final String jokeUrl = kAppApiUrl + '/jokes/';
  Dio dio = new Dio();

  Future<JokeListResponse> fetchAllJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {
    try {
      String type = EnumStringUtil().jokeTypeToString(jokeType);
      Response response = await dio.get(jokeUrl + '?type=$type&page=$page');
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<JokeListResponse> fetchUserFavJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {
    List<Joke> jokeListGen = List.generate(
        20,
        (num) => Joke((b) => b
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
    jokeList = jokeBuilder.build();
    return JokeListResponse((b) => b
      ..totalPages = 2
      ..currentPage = 1
      ..perPage = 10
      ..results = jokeList.toBuilder());
  }

  Future<JokeListResponse> fetchMovieJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      Movie movie,
      int page}) async {
    List<Joke> jokeListGen = List.generate(
        20,
        (num) => Joke((b) => b
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
    jokeList = jokeBuilder.build();
    return JokeListResponse((b) => b
      ..totalPages = 2
      ..currentPage = 1
      ..perPage = 10
      ..results = jokeList.toBuilder());
  }

  Future<JokeListResponse> fetchUserJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      User user,
      int page}) async {
    List<Joke> jokeListGen = List.generate(
        20,
        (num) => Joke((b) => b
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
    jokeList = jokeBuilder.build();
    return JokeListResponse((b) => b
      ..totalPages = 2
      ..currentPage = 1
      ..perPage = 10
      ..results = jokeList.toBuilder());
  }

  Future<CommentListResponse> getComments({String joke, int page}) async {
    var commentListGen = List.generate(
        20,
        (num) => Comment((b) => b
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
    commentList = commentBuilder.build();
    return CommentListResponse((b) => b
      ..totalPages = 2
      ..currentPage = 1
      ..perPage = 10
      ..results = commentList.toBuilder());
  }

  Future<Joke> addJoke({Joke joke, File imageToUpload}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      String type = EnumStringUtil().jokeTypeToString(joke.jokeType);

      Map<String, dynamic> gottenData = {
        'type': type,
        'title': joke.title,
        'movie': joke.movie.id,
        'content': (joke.jokeType == JokeType.text)
            ? joke.content
            : UploadFileInfo(imageToUpload, "upload.txt")
      };
      Map<String, dynamic> responseData = (joke.jokeType == JokeType.text)
          ? gottenData
          : FormData.from(gottenData);
      Response response = await dio.post(jokeUrl,
          data: responseData, options: authHeaderOption);
      return Joke.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<bool> likeJoke({Joke joke}) async {
    return true;
  }

  Future<bool> dislikeJoke({Joke joke}) async {
    return true;
  }

  Future<bool> favoriteJoke({Joke joke}) async {
    return true;
  }

  Future<bool> unfavoriteJoke({Joke joke}) async {
    return true;
  }

  FormData _createImageData() {
    return FormData.from({
      "name": "wendux",
      "age": 25,
      "file": new UploadFileInfo(new File("./example/upload.txt"), "upload.txt")
    });
  }
}
