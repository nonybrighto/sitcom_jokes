import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/movie_list_response.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';

class MovieService{


  Future<MovieListResponse> getMovies({int page}) async{

    var movieListGen =  List.generate(20, (num) => Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.title = 'name $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc') );


       BuiltList<Movie> movieList = BuiltList();
      var movieBuilder = movieList.toBuilder();
      movieBuilder.addAll(movieListGen);
      movieList =movieBuilder.build();
      return MovieListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  movieList.toBuilder());
    
  }

  Future<Movie>  getMovie(Movie movie) async{

    TmdbMovieDetails tmdbDetails = TmdbMovieDetails((b) => b..id=1..title='name');

    final tmbsmovieBuilder = tmdbDetails.toBuilder();
    return movie.rebuild((b) => b.tmdbDetails = tmbsmovieBuilder);
  }

  Future<Null> changeMovieFollow({String movieId, String userId, bool follow}){

      // put  /movie/following/:userId
      // delete to unfollow

        return null;
  }

  Future<List<Movie>> searchMovies(String searchText) async{

      List<Movie> movies = [
        Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.title = 'name $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'),
      Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.title = 'namew $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'),
      Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.title = 'namew $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'),
      Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.title = 'a $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'),
      Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.title = 'b $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'),
      ];


      List<Movie> gotten = movies.where((movie) => movie.basicDetails.title.startsWith(searchText)).toList();

        return gotten;
  }
}