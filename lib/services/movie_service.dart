import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/constants/secrets.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/movie_list_response.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';
import 'package:sitcom_joke/services/auth_header.dart';

class MovieService{


  Dio dio = Dio();

  final String moviesUrl = kAppApiUrl + '/movies/';
  final String tmdbmovieUrl =kTmdbApiUrl + '/movie/';

  Future<MovieListResponse> getMovies({int page}) async{

    try {
      Options authHeaderOption = await getAuthHeaderOption();
      Response response = await dio.get(moviesUrl + '?page=$page', options: authHeaderOption);
        return MovieListResponse.fromJson(response.data);

    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
  }

  Future<Movie>  getMovie(Movie movie) async{

    String tmdbMovieUrl = tmdbmovieUrl+'${movie.tmdbMovieId}?api_key=$kTmdbApiKey&append_to_response=credits,images';

     try {

      Options authHeaderOption = await getAuthHeaderOption();
      List<Response> response = await Future.wait([dio.get(tmdbMovieUrl), dio.get(moviesUrl+'${movie.id}', options: authHeaderOption)]);
      TmdbMovieDetails tmdbMovieDetails = TmdbMovieDetails.fromJson(response[0].data);
      Movie gottenMovie =  Movie.fromJson(response[1].data);
      return gottenMovie.rebuild((b) => b.tmdbDetails = tmdbMovieDetails.toBuilder());

    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
   
  }

  Future<bool> changeMovieFollow({Movie movie, bool follow}) async{

        try {
          Options authHeaderOption = await getAuthHeaderOption();
          if(follow){
              await dio.put(moviesUrl + '${movie.id}/following', options: authHeaderOption);
          }else{
              await dio.delete(moviesUrl + '${movie.id}/following', options: authHeaderOption);
          }
          return true;
        } on DioError catch (error) {
          throw Exception((error.response != null)
              ? error.response.data['message']
              : 'Error Connectiing to server');
        }
  }

  Future<List<Movie>> searchMovies(String searchText) async{

      List<Movie> movies = [
        Movie((b) => b
      ..id = 'abcde'
      ..title = 'name $num'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'),
      Movie((b) => b
      ..id = 'abcde'
      ..title = 'namew $num'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'),
      Movie((b) => b
      ..id = 'abcde'
      ..title = 'namew $num'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'),
      Movie((b) => b
      ..id = 'abcde'
      ..title = 'a $num'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'),
      Movie((b) => b
      ..id = 'abcde'
      ..title = 'b $num'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'),
      ];


      List<Movie> gotten = movies.where((movie) => movie.title.startsWith(searchText)).toList();

        return gotten;
  }
}