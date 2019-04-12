import 'dart:async';

import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';

class JokeControlBloc extends BlocBase{
  

  Joke jokeControlled;
  JokeListBloc jokeListBloc;
  JokeService jokeService;

  final _toggleJokeLike = StreamController<Null>();
  final _toggleJokeFavorite = StreamController<Null>();

  void Function() get toggleJokeLike => () => _toggleJokeLike.sink.add(null);
  void Function() get toggleJokeFavorite => () => _toggleJokeFavorite.sink.add(null);

  JokeControlBloc({this.jokeControlled, this.jokeListBloc, this.jokeService}){

    _toggleJokeLike.stream.listen(_handleToggleJokeLike);
    _toggleJokeFavorite.stream.listen(_handleToggleJokeFavorite);
  }

  _handleToggleJokeLike(_)  async{

      Joke toggledJoke = _toggledJokeLike();
      jokeListBloc?.updateItem(toggledJoke);
      jokeListBloc?.changeCurrentJoke(toggledJoke);
      try{
          jokeControlled = toggledJoke;
          await jokeService.changeJokeLiking(joke: jokeControlled, like:(jokeControlled.liked)?false:true);
      }catch(err){
          print(err);
          jokeControlled = _toggledJokeLike();
          jokeListBloc?.updateItem(jokeControlled);
          jokeListBloc?.changeCurrentJoke(jokeControlled);
      }
    
  }
  _handleToggleJokeFavorite(_) async{

    Joke toggledJoke = _toggledJokeFavorite();
      jokeListBloc?.updateItem(toggledJoke);
      jokeListBloc?.changeCurrentJoke(toggledJoke);
      try{
          jokeControlled = toggledJoke;
          await jokeService.changeJokeFavoriting(joke: jokeControlled, favorite:(jokeControlled.favorited)?true:false);
      }catch(err){
          jokeControlled = _toggledJokeFavorite();
          jokeListBloc?.updateItem(jokeControlled);
          jokeListBloc?.changeCurrentJoke(jokeControlled);
      }
    
  }

  Joke _toggledJokeLike(){
        Joke joke =jokeControlled;
        return joke.rebuild((b) => b..liked = !b.liked..likeCount = (joke.liked)? --b.likeCount: ++b.likeCount);
  }
  Joke _toggledJokeFavorite(){
        Joke joke =jokeControlled;
        return joke.rebuild((b) => b.favorited = !b.favorited);
  }

  
  @override
  void dispose() {
    _toggleJokeLike.close();
    _toggleJokeFavorite.close();
  }


}