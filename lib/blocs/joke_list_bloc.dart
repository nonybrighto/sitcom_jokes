import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/joke_service.dart';


class JokeListBloc extends ListBloc<Joke>{
 
 final JokeService jokeService;

  JokeListFetchType fetchType =JokeListFetchType.latestJokes;
  Movie movie;
  User user;

  final _currentJokeController =BehaviorSubject<Joke>();


  //stream
  Stream<Joke> get currentJoke => _currentJokeController.stream;

  //sinks
  void Function(Joke joke) get changeCurrentJoke => (joke) => _currentJokeController.sink.add(joke);
 
 JokeListBloc({this.jokeService, this.fetchType, this.user, this.movie}){

    if(fetchType != null){
          getItems();
    }

 }
 
  @override
  void dispose() {

  }

  @override
  Future<JokeListResponse> fetchFromServer() async{

    switch (fetchType) {
      case JokeListFetchType.userFavJokes:
       return await jokeService.fetchUserFavJokes(page: currentPage);
      break;
      case JokeListFetchType.movieJokes:
       return await jokeService.fetchMovieJokes(movie: movie, page: currentPage);
      break;
      case JokeListFetchType.userJokes:
       return await jokeService.fetchUserJokes(user: user, page: currentPage);
      break;
      case JokeListFetchType.latestJokes:
       return await jokeService.fetchLatestJokes( page: currentPage );
      break;
      case JokeListFetchType.popularJokes:
       return await jokeService.fetchPopularJokes( page: currentPage );
      break;
      default:
        return null;

    }
  }


  close(){
   _currentJokeController.close();
  }

  @override
  bool itemIdentificationCondition(Joke currentJoke, Joke updatedJoke) {
    return currentJoke.id == updatedJoke.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Jokes to display';
  }
}

enum JokeListFetchType{ userFavJokes, movieJokes, latestJokes, userJokes, popularJokes }