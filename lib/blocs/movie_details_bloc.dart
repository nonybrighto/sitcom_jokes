import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/services/movie_service.dart';

class MovieDetialsBloc extends BlocBase{
 
  Movie movieToget;
  final MovieService movieService;
  Function(String) _followErrorCallBack;

  final _movieController = BehaviorSubject<Movie>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getMovieDetailsController = StreamController<Null>();
  final _changeMovieFollowController = StreamController<Null>();

  //stream
  Stream<LoadState> get loadState => _loadStateController.stream;
  Stream<Movie> get movie => _movieController.stream;

  //sink
  void Function() get getMovieDetails => () => _getMovieDetailsController.sink.add(null);
  void changeMovieFollow(Function(String) errorCallBack){  _followErrorCallBack = errorCallBack; _changeMovieFollowController.sink.add(null); }

  MovieDetialsBloc({this.movieToget, this.movieService}){
      
        _movieController.sink.add(movieToget);
        if(!movieToget.hasFullDetails()){
           getMovieDetails();
        }else{
           _loadStateController.sink.add(Loaded());
        }

      _getMovieDetailsController.stream.listen((_){
            _getMovieFromSource();
      });

      _changeMovieFollowController.stream.listen((_){
        _changeMovieFollow();
         
      });
  }


  _changeMovieFollow() async{
     bool shouldFollow = movieToget.basicDetails.followed;
         
         try{
          _swapFollowState();
          await movieService.changeMovieFollow(movieId:  movieToget.basicDetails.id, userId: null, follow: shouldFollow);
         }catch(err){
          _swapFollowState();
          _followErrorCallBack('Error while following movie '+movieToget.basicDetails.name);
         }

  }

  _swapFollowState(){

     movieToget = movieToget.rebuild((b) => b.basicDetails.followed =  !movieToget.basicDetails.followed);
    _movieController.sink.add(movieToget);
  }

  _getMovieFromSource() async{
    _loadStateController.sink.add(Loading());
        try{
            Movie movieGotten = await movieService.getMovie(movieToget);
             movieToget  = movieGotten;
            _movieController.sink.add(movieGotten);
            _loadStateController.sink.add(Loaded());
        }catch(err){
            _loadStateController.sink.add(LoadError('Could not get MovieDetails'));
        }
  }
  
  @override
  void dispose() {
    _movieController.close();
    _loadStateController.close();
    _getMovieDetailsController.close();
    _changeMovieFollowController.close();
  }


}