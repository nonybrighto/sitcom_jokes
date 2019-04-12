import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/comment_list_response.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/auth_header.dart';
import 'package:sitcom_joke/utils/enum_string_util.dart';

class JokeService {
  final String jokesUrl = kAppApiUrl + '/jokes/';
  final String userUrl = kAppApiUrl + '/user/';
  final String usersUrl = kAppApiUrl + '/users/';
  final String moviesUrl = kAppApiUrl + '/movies/';
  Dio dio = new Dio();

  Future<JokeListResponse> fetchAllJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      String type = EnumStringUtil().jokeTypeToString(jokeType);
      Response response = await dio.get(jokesUrl + '?type=$type&page=$page', options: authHeaderOption);
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


    try {
       Options authHeaderOption = await getAuthHeaderOption();
      String type = EnumStringUtil().jokeTypeToString(jokeType);
      Response response = await dio.get(userUrl + 'favorites/jokes?type=$type&page=$page', options:authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<JokeListResponse> fetchMovieJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      Movie movie,
      int page}) async {

          try {
       Options authHeaderOption = await getAuthHeaderOption();
      String type = EnumStringUtil().jokeTypeToString(jokeType);
      Response response = await dio.get(moviesUrl + '${movie.id}/jokes?type=$type&page=$page', options:authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }

  }

  Future<JokeListResponse> fetchUserJokes(
      {JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      User user,
      int page}) async {
  
        
    try {
       Options authHeaderOption = await getAuthHeaderOption();
      String type = EnumStringUtil().jokeTypeToString(jokeType);
      Response response = await dio.get(usersUrl + '${user.id}/jokes?type=$type&page=$page', options:authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }


  }

  Future<CommentListResponse> getComments({Joke joke, int page}) async {
   
   try {
      Response response = await dio.get(jokesUrl + '/${joke.id}/comments?page=$page');
      return CommentListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
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
      Response response = await dio.post(jokesUrl,
          data: responseData, options: authHeaderOption);
      return Joke.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<bool> changeJokeLiking({Joke joke, bool like}) async {
    try {
       Options authHeaderOption = await getAuthHeaderOption();
       if(like){
          await dio.put(jokesUrl + '/${joke.id}/likes', options: authHeaderOption);
       }else{
          await dio.delete(jokesUrl + '/${joke.id}/likes', options: authHeaderOption);
       }
      return true;
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<bool> changeJokeFavoriting({Joke joke, bool favorite}) async {
     try {
       Options authHeaderOption = await getAuthHeaderOption();
       if(favorite){
          await dio.put(userUrl + '/favorites/jokes/${joke.id}', options: authHeaderOption);
       }else{
          await dio.delete(userUrl + '/favorites/jokes/${joke.id}', options: authHeaderOption);
       }
      return true;
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }
}
