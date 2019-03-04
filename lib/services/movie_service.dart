import 'dart:async';

import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_details.dart';

class MovieService{


  Future<List<Movie>> getMovies({int page}) async{

        return List.generate(20, (num) => Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.name = 'name $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc') );
    
  }

  Future<Movie>  getMovie(Movie movie) async{

    TmdbMovieDetails tmdbDetails = TmdbMovieDetails((b) => b..id=1..name='name');

    final tmbsmovieBuilder = tmdbDetails.toBuilder();
    return movie.rebuild((b) => b.tmdbDetails = tmbsmovieBuilder);
  }

  Future<Null> changeMovieFollow({String movieId, String userId, bool follow}){

      // put  /movie/following/:userId
      // delete to unfollow

        return null;
  }
}