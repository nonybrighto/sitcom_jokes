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
          if(jokeControlled.isLiked){
              jokeControlled = toggledJoke;
              await jokeService.dislikeJoke(joke: jokeControlled);
          }else{
              jokeControlled = toggledJoke;
              await jokeService.likeJoke(joke: jokeControlled);
          }
    
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
          if(jokeControlled.isFavorited){
              jokeControlled = toggledJoke;
              await jokeService.favoriteJoke(joke: jokeControlled);
          }else{
              jokeControlled = toggledJoke;
              await jokeService.unfavoriteJoke(joke: jokeControlled);
          }
    
      }catch(err){
            print(err);
            jokeControlled = _toggledJokeFavorite();
            jokeListBloc?.updateItem(jokeControlled);
            jokeListBloc?.changeCurrentJoke(jokeControlled);
      }
    
  }

  Joke _toggledJokeLike(){
        Joke joke =jokeControlled;
        return joke.rebuild((b) => b..isLiked = !b.isLiked..likes = (joke.isLiked)? --b.likes: ++b.likes);
  }
  Joke _toggledJokeFavorite(){
        Joke joke =jokeControlled;
        return joke.rebuild((b) => b.isFavorited = !b.isFavorited);
  }

  
  @override
  void dispose() {
    _toggleJokeLike.close();
    _toggleJokeFavorite.close();
  }


}