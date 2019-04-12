import 'dart:async';
import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/movie_list_response.dart';
import 'package:sitcom_joke/services/movie_service.dart';


class MovieListBloc extends ListBloc<Movie>{
 
 final MovieService movieService;


  //stream


  //sink



 
 MovieListBloc({this.movieService}){
      super.getItems();
 }
 
  @override
  void dispose() {

  }

  @override
  Future<MovieListResponse> fetchFromServer() async{
    return  await movieService.getMovies(page: super.currentPage);
  }

  @override
  bool itemUpdateCondition(Movie currentMovie, Movie updatedMovie) {
    return currentMovie.id == updatedMovie.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Movies to display';
  }
}
