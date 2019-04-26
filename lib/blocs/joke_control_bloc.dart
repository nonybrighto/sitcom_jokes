import 'dart:async';
import 'dart:ui' as ui;

import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/utils/joke_save_util.dart';

class JokeControlBloc extends BlocBase {
  Joke jokeControlled;
  JokeListBloc jokeListBloc;
  JokeService jokeService;

  final _toggleJokeLikeController = StreamController<Null>();
  final _toggleJokeFavoriteController = StreamController<Null>();
  final _saveJokeController = StreamController<Null>();
  final _shareJokeController = StreamController<Null>();

  void Function() get toggleJokeLike =>
      () => _toggleJokeLikeController.sink.add(null);
  void Function() get toggleJokeFavorite =>
      () => _toggleJokeFavoriteController.sink.add(null);
  final _loadStateController = StreamController<LoadState>();

  final _saveTextJokeController = StreamController<Map<String, dynamic>>();
  final _saveImageJokeController = StreamController<Map<String, dynamic>>();

  void Function(ui.Image, Function(String)) get saveTextJoke =>
      (jokeImage, saveCallback) => _saveTextJokeController.sink
          .add({'jokeImage': jokeImage, 'saveCallback': saveCallback});

  void Function(Function(String)) get saveImageJoke => (saveCallback) =>
      _saveImageJokeController.sink.add({'saveCallback': saveCallback});

  //stream
  Stream<LoadState> get loadState => _loadStateController.stream;

  JokeControlBloc({this.jokeControlled, this.jokeListBloc, this.jokeService}) {
    _toggleJokeLikeController.stream.listen(_handleToggleJokeLike);
    _toggleJokeFavoriteController.stream.listen(_handleToggleJokeFavorite);
    // _shareJokeController.stream.listen(_handleShareJoke);
    _saveTextJokeController.stream.listen(_handleSaveTextJoke);
    _saveImageJokeController.stream.listen(_handleSaveImageJoke);
  }

  _handleSaveImageJoke(details) async {
    _loadStateController.sink.add(Loading());

    Function(String) saveCallback = details['saveCallback'];
    try {
      await JokeSaveUtil().saveImage(jokeControlled.imageUrl, jokeControlled.id,
          jokeControlled.getImageExtension());
      saveCallback('Joke has been saved!!');
    } catch (err) {
      saveCallback('Failed to save joke!!');
    }

    _loadStateController.sink.add(Loaded());
  }

  _handleSaveTextJoke(details) async {
    _loadStateController.sink.add(Loading());
    ui.Image jokeImage = details['jokeImage'];

    Function(String) saveCallback = details['saveCallback'];
    try {
      await JokeSaveUtil().saveText(jokeImage, jokeControlled.id);
      saveCallback('Joke has been saved!!');
    } catch (err) {
      saveCallback('Failed to save joke!!');
    }

    _loadStateController.sink.add(Loaded());
  }

  // _handleShareJoke(_){

  //      // JokeShareUtil jokeShareUtil = JokeShareUtil();
  //       if(jokeControlled.hasImage()){
  //        // jokeShareUtil.shareImageJoke(jokeControlled);
  //       }else{
  //        // jokeShareUtil.shareTextJoke(jokeControlled);
  //       }

  // }

  _handleToggleJokeLike(_) async {
    _toggleLike();
    jokeListBloc?.updateItem(jokeControlled);
    jokeListBloc?.changeCurrentJoke(jokeControlled);
    try {
      await jokeService.changeJokeLiking(
          joke: jokeControlled, like: jokeControlled.liked);
    } catch (err) {
      print(err);
      _toggleLike();
      jokeListBloc?.updateItem(jokeControlled);
      jokeListBloc?.changeCurrentJoke(jokeControlled);
    }
  }

  _handleToggleJokeFavorite(_) async {
    _toggleFavorite();
    jokeListBloc?.updateItem(jokeControlled);
    jokeListBloc?.changeCurrentJoke(jokeControlled);
    try {
      await jokeService.changeJokeFavoriting(
          joke: jokeControlled, favorite: jokeControlled.favorited);
    } catch (err) {
      _toggleFavorite();
      jokeListBloc?.updateItem(jokeControlled);
      jokeListBloc?.changeCurrentJoke(jokeControlled);
    }
  }

  _toggleLike() {
    jokeControlled = jokeControlled.rebuild((b) => b
      ..liked = !b.liked
      ..likeCount = (jokeControlled.liked) ? --b.likeCount : ++b.likeCount);
  }

  _toggleFavorite() {
    jokeControlled = jokeControlled.rebuild((b) => b.favorited = !b.favorited);
  }

  @override
  void dispose() {
    print('Joke control disposed for ${jokeControlled.title}');
    _toggleJokeLikeController.close();
    _toggleJokeFavoriteController.close();
    _saveJokeController.close();
    _shareJokeController.close();
    _loadStateController.close();
    _saveTextJokeController.close();
    _saveImageJokeController.close();
  }
}
