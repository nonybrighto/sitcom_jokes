import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/services/joke_service.dart';

class JokeCommentListBloc extends BlocBase{
 
 
  final Joke commentJoke;
  final JokeService jokeService;

  int _currentPage = 1;
  List<Comment> _comments = [];


  final _jokeController = BehaviorSubject<Joke>();
  final _commentsController =BehaviorSubject<UnmodifiableListView<Comment>>();
  final _loadStateController =BehaviorSubject<LoadState>();
  final _getCommentsController = StreamController<Null>();


  //streams
  Stream<Joke> get joke => _jokeController.stream; 
  Stream<UnmodifiableListView<Comment>> get comments => _commentsController.stream;
  Stream<LoadState> get loadState => _loadStateController.stream;

  //sink
  void Function() get getComments => () => _getCommentsController.sink.add(null);

  JokeCommentListBloc(this.commentJoke, {this.jokeService}){

      _jokeController.sink.add(commentJoke);

      getComments();

      _getCommentsController.stream.listen((_){

            _retrieveCommentFromSource();

      });

  }

  _retrieveCommentFromSource() async{

        if(_currentPage == 1){
      _loadStateController.sink.add(Loading());
        }else{
          _loadStateController.sink.add(LoadingMore());
        }

        try{
      List<Comment> gottenComments = await jokeService.getComments(joke:commentJoke.id, page:_currentPage);
      if(_currentPage == 1){
        if(gottenComments.isEmpty){
          _loadStateController.sink.add(LoadEmpty('No comments to load'));
        }else{
          _changeComments(gottenComments);
          _loadStateController.sink.add(Loaded());
        }

      }else{
        if(gottenComments.isEmpty){
          _loadStateController.sink.add(LoadEnd());
        }else {
          _appendComments(gottenComments);
          _loadStateController.sink.add(Loaded());
        }
      }

      _currentPage++;
    }catch(err){
      if (_currentPage == 1){
        _loadStateController.sink.add(LoadError('Error during the loading of comments'));
      }else{
        _loadStateController.sink.add(LoadMoreError('Error while loading more comments'));
      }
    }
  }

   _appendComments(List<Comment> gottenComments){
          _comments.addAll(gottenComments);
          _commentsController.sink.add(UnmodifiableListView(_comments));
  }

  _changeComments(List<Comment> gottenComments){
          _comments = gottenComments;
          _commentsController.sink.add(UnmodifiableListView(_comments));
  }
 
  @override
  void dispose() {
    _jokeController.close();
    _commentsController.close();
    _getCommentsController.close();
    _loadStateController.close();
  }

}