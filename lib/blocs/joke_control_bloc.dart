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

      _toggleLike();
      jokeListBloc?.updateItem(jokeControlled);
      jokeListBloc?.changeCurrentJoke(jokeControlled);
      try{
          await jokeService.changeJokeLiking(joke: jokeControlled, like:jokeControlled.liked);
      }catch(err){
          print(err);
          _toggleLike();
          jokeListBloc?.updateItem(jokeControlled);
          jokeListBloc?.changeCurrentJoke(jokeControlled);
      }
    
  }
  _handleToggleJokeFavorite(_) async{

      _toggleFavorite();
      jokeListBloc?.updateItem(jokeControlled);
      jokeListBloc?.changeCurrentJoke(jokeControlled);
      try{
          await jokeService.changeJokeFavoriting(joke: jokeControlled, favorite:jokeControlled.favorited);
      }catch(err){
          _toggleFavorite();
          jokeListBloc?.updateItem(jokeControlled);
          jokeListBloc?.changeCurrentJoke(jokeControlled);
      }
    
  }

  _toggleLike(){
        jokeControlled = jokeControlled.rebuild((b) => b..liked = !b.liked..likeCount = (jokeControlled.liked)? --b.likeCount: ++b.likeCount);
  }
  _toggleFavorite(){
      jokeControlled = jokeControlled.rebuild((b) => b.favorited = !b.favorited);
  }

  
  @override
  void dispose() {
    print('Joke control disposed');
    _toggleJokeLike.close();
    _toggleJokeFavorite.close();
  }


}