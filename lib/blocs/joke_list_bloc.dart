import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';

import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/movie.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/services/joke_service.dart';

class JokeListBloc extends BlocBase{
 
  final JokeService jokeService;
  final JokeType jokeType;

  int _currentPage  = 1;
  List<Joke> _jokes = [];

  bool _favorites = false;
  SortOrder _sortOrder = SortOrder.desc;
  JokeSortProperty _sortProperty = JokeSortProperty.dataAdded;
  Movie _movie;

  final _jokesController =  BehaviorSubject<UnmodifiableListView<Joke>>();
  //final _jokesController =  StreamController<UnmodifiableListView<Joke>>.broadcast();
  final _favoritesController = StreamController<bool>();
  final _sortOrderController = StreamController<SortOrder>();
  final _sortPropertyController = StreamController<JokeSortProperty>();
  final _movieController = StreamController<Movie>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getJokesController = StreamController<Null>();


  //streams
  Stream<UnmodifiableListView<Joke>> get jokes => _jokesController.stream;
  Stream<LoadState> get loadState => _loadStateController.stream;

  Stream<bool> get favorites => _favoritesController.stream;
  Stream<SortOrder> get sortOrder => _sortOrderController.stream;
  Stream<JokeSortProperty> get sortProperty => _sortPropertyController.stream;
  Stream<Movie> get movie => _movieController.stream;

  //sinks
  void Function() get getJokes => () => _getJokesController.sink.add(null);


 
  JokeListBloc(this.jokeType, {this.jokeService}){

    _favoritesController.sink.add(false);
    _sortOrderController.sink.add(SortOrder.desc);
    _sortPropertyController.sink.add(JokeSortProperty.dataAdded);
    _movieController.sink.add(null);

     getJokes();

    _getJokesController.stream.listen((_){
        _retrieveJokesFromSource();
    });

  }

  _retrieveJokesFromSource() async{

    if(_currentPage == 1){
      _loadStateController.sink.add(Loading());
    }else{
      _loadStateController.sink.add(LoadingMore());
    }

    try{
      List<Joke> gottenJokes = await jokeService.getJokes(jokeType: jokeType, favorite: _favorites, sortOrder: _sortOrder, jokeSortProperty: _sortProperty, movie: _movie, page: _currentPage );
      if(_currentPage == 1){
        if(gottenJokes.isEmpty){
          _loadStateController.sink.add(LoadEmpty('No Jokes to load'));
        }else{
          _changeJokes(gottenJokes);
          _loadStateController.sink.add(Loaded());
        }

      }else{
        if(gottenJokes.isEmpty){
          _loadStateController.sink.add(LoadEnd());
        }else {
          _appendJokes(gottenJokes);
          _loadStateController.sink.add(Loaded());
        }
      }

      _currentPage++;
    }catch(err){
      if (_currentPage == 1){
        _loadStateController.sink.add(LoadError('Error during the loading of joke'));
      }else{
        _loadStateController.sink.add(LoadMoreError('Error while loading more jokes'));
      }
    }
  }

  _appendJokes(List<Joke> gottenJokes){
          _jokes.addAll(gottenJokes);
          _jokesController.sink.add(UnmodifiableListView(_jokes));
  }

  _changeJokes(List<Joke> gottenJokes){
          _jokes = gottenJokes;
          _jokesController.sink.add(UnmodifiableListView(_jokes));
  }

  @override
  void dispose() {
//    _jokesController.close();
//    _favoritesController.close();
//    _sortOrderController.close();
//    _sortPropertyController.close();
//    _movieController.close();
//    _loadStateController.close();
//    _getJokesController.close();
  }
}