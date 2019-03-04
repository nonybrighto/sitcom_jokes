import 'dart:async';
import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
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
  Future<List<Movie>> retrieveFromServer() async{
    return  await movieService.getMovies(page: super.currentPage);
  }

  @override
  bool itemUpdateCondition(Movie currentMovie, Movie updatedMovie) {
    return currentMovie.basicDetails.id == updatedMovie.basicDetails.id;
  }
}
