import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';


class JokeListBloc extends ListBloc<Joke>{
 
 final JokeService jokeService;
 final JokeType jokeType;

  bool _favorites = false;
  SortOrder _sortOrder = SortOrder.desc;
  JokeSortProperty _sortProperty = JokeSortProperty.dataAdded;
  Movie _movie;

  final _currentJokeController =BehaviorSubject<Joke>();
  final _favoritesController = StreamController<bool>();
  final _sortOrderController = StreamController<SortOrder>();
  final _sortPropertyController = StreamController<JokeSortProperty>();
  final _movieController = StreamController<Movie>();


  //stream
  Stream<Joke> get currentJoke => _currentJokeController.stream;
  Stream<bool> get favorites => _favoritesController.stream;
  Stream<SortOrder> get sortOrder => _sortOrderController.stream;
  Stream<JokeSortProperty> get sortProperty => _sortPropertyController.stream; 
  Stream<Movie> get movie => _movieController.stream;

  //sinks
  void Function(Joke joke) get changeCurrentJoke => (joke) => _currentJokeController.sink.add(joke);
  void changeFavorites(favorites){ _favorites = favorites; _favoritesController.sink.add(favorites); _restoreConf(); }
  void changeSortOrder(sortOrder){ _sortOrder = sortOrder; _sortOrderController.sink.add(sortOrder); _restoreConf();}
  void changeSortProperty(sortProperty){ _sortProperty = sortProperty;  _sortPropertyController.sink.add(sortProperty); _restoreConf(); }
  void changeMovie(movie){ _movie = movie;  _movieController.sink.add(movie);  _restoreConf(); }


 
 JokeListBloc(this.jokeType, {this.jokeService}){

    _favoritesController.sink.add(false);
    _sortOrderController.sink.add(SortOrder.desc);
    _sortPropertyController.sink.add(JokeSortProperty.dataAdded);
    _movieController.sink.add(null);

    super.getItems();
 }
 
  @override
  void dispose() {

  }

  @override
  Future<List<Joke>> fetchFromServer() async{
    


    return  await jokeService.getJokes(jokeType: jokeType, favorite: _favorites, sortOrder: _sortOrder, jokeSortProperty: _sortProperty, movie: _movie, page: super.currentPage );
  }

  _restoreConf(){
    super.currentPage = 1;
  }

  close(){
   _favoritesController.close();
   _sortOrderController.close();
   _sortPropertyController.close();
   _movieController.close();
   _currentJokeController.close();
  }

  @override
  bool itemUpdateCondition(Joke currentJoke, Joke updatedJoke) {
    return currentJoke.id == updatedJoke.id;
  }
}