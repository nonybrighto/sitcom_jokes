import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/joke_service.dart';


class JokeListBloc extends ListBloc<Joke>{
 
 final JokeService jokeService;
 final JokeType jokeType;

  JokeListFetchType fetchType =JokeListFetchType.allJokes;
  SortOrder _sortOrder = SortOrder.desc;
  JokeSortProperty _sortProperty = JokeSortProperty.dataAdded;
  Movie _movie;
  User _user;

  final _currentJokeController =BehaviorSubject<Joke>();
  final _sortOrderController = StreamController<SortOrder>();
  final _sortPropertyController = StreamController<JokeSortProperty>();
  final _movieController = StreamController<Movie>();
  final _fetchAllJokesController =StreamController<Null>();
  final _fetchUserFavoriteJokesController =StreamController<Null>();
  final _fetchMovieJokesController =StreamController<Movie>();
  final _fetchUserJokesController =StreamController<User>();


  //stream
  Stream<Joke> get currentJoke => _currentJokeController.stream;
  Stream<SortOrder> get sortOrder => _sortOrderController.stream;
  Stream<JokeSortProperty> get sortProperty => _sortPropertyController.stream; 
  Stream<Movie> get movie => _movieController.stream;

  //sinks
  void Function(Joke joke) get changeCurrentJoke => (joke) => _currentJokeController.sink.add(joke);
  void Function() get fetchAllJokes => () => _fetchAllJokesController.sink.add(null);
  void Function() get fetchUserFavoriteJokes => () => _fetchUserFavoriteJokesController.sink.add(null);
  void Function(Movie) get fetchMovieJokes => (movie) => _fetchMovieJokesController.sink.add(movie);
  void Function(User) get fetchUserJokes => (user) => _fetchUserJokesController.sink.add(user);
  
  void changeSortOrder(sortOrder){ _sortOrder = sortOrder; _sortOrderController.sink.add(sortOrder); _restoreConf();}
  void changeSortProperty(sortProperty){ _sortProperty = sortProperty;  _sortPropertyController.sink.add(sortProperty); _restoreConf(); }


 
 JokeListBloc(this.jokeType, {this.jokeService}){

    _sortOrderController.sink.add(SortOrder.desc);
    _sortPropertyController.sink.add(JokeSortProperty.dataAdded);
    _movieController.sink.add(null);


    _fetchAllJokesController.stream.listen((_){
        fetchType = JokeListFetchType.allJokes;
       _getFirstPageJokes();
    });

    _fetchUserFavoriteJokesController.stream.listen((_){
        fetchType = JokeListFetchType.userFavJokes;
        _getFirstPageJokes();
    });

    _fetchMovieJokesController.stream.listen((movie){
        _movie = movie;
        fetchType = JokeListFetchType.movieJokes;
        _getFirstPageJokes();
    });

    _fetchUserJokesController.stream.listen((user){
        _user = user;
        fetchType = JokeListFetchType.userJokes;
        _getFirstPageJokes();
    });
 }
 
  @override
  void dispose() {

  }

  @override
  Future<JokeListResponse> fetchFromServer() async{

    switch (fetchType) {
      case JokeListFetchType.userFavJokes:
       return await jokeService.fetchUserFavJokes(jokeType: jokeType, jokeSortProperty: _sortProperty, sortOrder: _sortOrder, page: super.currentPage);
      break;
      case JokeListFetchType.movieJokes:
       return await jokeService.fetchMovieJokes(jokeType: jokeType, movie: _movie, jokeSortProperty: _sortProperty, sortOrder: _sortOrder, page: super.currentPage);
      break;
      case JokeListFetchType.userJokes:
       return await jokeService.fetchUserJokes(jokeType: jokeType, user: _user, jokeSortProperty: _sortProperty, sortOrder: _sortOrder, page: super.currentPage);
      break;
      case JokeListFetchType.allJokes:
       return await jokeService.fetchAllJokes(jokeType: jokeType, sortOrder: _sortOrder, jokeSortProperty: _sortProperty, page: super.currentPage );
      break;
      default:
        return null;

    }
  }

  _getFirstPageJokes(){
     currentPage = 1;
     getItems();
  }

  _restoreConf(){
    super.currentPage = 1;
  }

  close(){
   _sortOrderController.close();
   _sortPropertyController.close();
   _movieController.close();
   _currentJokeController.close();
   _fetchAllJokesController.close();
   _fetchMovieJokesController.close();
   _fetchUserFavoriteJokesController.close();
   _fetchUserJokesController.close();
  }

  @override
  bool itemUpdateCondition(Joke currentJoke, Joke updatedJoke) {
    return currentJoke.id == updatedJoke.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Jokes to display';
  }
}

enum JokeListFetchType{ userFavJokes, movieJokes, allJokes, userJokes }