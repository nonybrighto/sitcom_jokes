import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/movie_list_response.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';
import 'package:sitcom_joke/services/auth_header.dart';

class MovieService{


  Dio dio = Dio();

  final String moviesUrl = kAppApiUrl + '/movies/';

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

    TmdbMovieDetails tmdbDetails = TmdbMovieDetails((b) => b..id=1..title='name');

    final tmbsmovieBuilder = tmdbDetails.toBuilder();
    return movie.rebuild((b) => b.tmdbDetails = tmbsmovieBuilder);
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