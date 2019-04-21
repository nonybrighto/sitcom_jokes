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

class JokeService {
  final String jokesUrl = kAppApiUrl + '/jokes/';
  final String userUrl = kAppApiUrl + '/user/';
  final String usersUrl = kAppApiUrl + '/users/';
  final String moviesUrl = kAppApiUrl + '/movies/';
  Dio dio = new Dio();

  Future<JokeListResponse> fetchAllJokes(
      {
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page,}) async {
    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(jokesUrl + '?page=$page', options: authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<JokeListResponse> fetchUserFavJokes(
      {
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      int page}) async {


    try {
       Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(userUrl + 'favorites/jokes?page=$page', options:authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<JokeListResponse> fetchMovieJokes(
      {
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      Movie movie,
      int page}) async {

          try {
       Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(moviesUrl + '${movie.id}/jokes?page=$page', options:authHeaderOption);
      return JokeListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }

  }

  Future<JokeListResponse> fetchUserJokes(
      {
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      User user,
      int page}) async {
  
        
    try {
       Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(usersUrl + '${user.id}/jokes?page=$page', options:authHeaderOption);
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

      Map<String, dynamic> gottenData = {
        'title': joke.title,
        'movie': joke.movie.id,
      }..addAll((imageToUpload != null)? {'image': UploadFileInfo(imageToUpload, "joke_image")}:{})
      ..addAll((joke.text.isNotEmpty)? {'text': joke.text}:{});

      Map<String, dynamic> responseData = (imageToUpload == null)
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
          await dio.put(jokesUrl + '${joke.id}/likes', options: authHeaderOption);
       }else{
          await dio.delete(jokesUrl + '${joke.id}/likes', options: authHeaderOption);
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
          await dio.put(userUrl + 'favorites/jokes/${joke.id}', options: authHeaderOption);
       }else{
          await dio.delete(userUrl + 'favorites/jokes/${joke.id}', options: authHeaderOption);
       }
      return true;
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }
}
