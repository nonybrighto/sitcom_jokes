import 'dart:async';

import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/services/movie_service.dart';

class MovieControlBloc extends BlocBase{
  
  Movie movieControlled;
  MovieListBloc movieListBloc;
  MovieDetailsBloc movieDetailsBloc;
  MovieService movieService;
  
    final _toggleMovieFollow = StreamController<Null>();
  
    void Function() get toggleMovieFollow => () => _toggleMovieFollow.sink.add(null);
  
    MovieControlBloc({this.movieControlled, this.movieListBloc, this.movieDetailsBloc, this.movieService}){
  
      _toggleMovieFollow.stream.listen(_handleToggleMovieFollow);
    }
  
    _handleToggleMovieFollow(_)  async{
        _updateMovie();
        _toggleFollow();
        _updateMovieInControlledBlocs();
        try{
            await movieService.changeMovieFollow(movie: movieControlled, follow:movieControlled.followed);
        }catch(err){
          _toggleFollow();
          _updateMovieInControlledBlocs();
        } 
    }
  
    _toggleFollow(){
          movieControlled = movieControlled.rebuild((b) => b..followed = !b.followed);
    }
  
    //Gets the latest details of the movie that the movie details bloc retrieves from the server so that it doesn't send stale data
    _updateMovie(){
      movieControlled = movieDetailsBloc?.viewedMovie ?? movieControlled;
    }
  
    //notify list and detail blocs of changes that have taken place
    _updateMovieInControlledBlocs(){
        movieListBloc?.updateItem(movieControlled);
        movieDetailsBloc?.updateMovie(movieControlled);
    }
    
    @override
    void dispose() {
      _toggleMovieFollow.close();
    }
  
  
  }