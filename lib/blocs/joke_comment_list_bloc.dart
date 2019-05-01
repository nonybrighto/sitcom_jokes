import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/models/comment_list_response.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';


class JokeCommentListBloc extends ListBloc<Comment>{
 
 final Joke commentJoke;
 final JokeService jokeService;

  final _jokeController = BehaviorSubject<Joke>();


  //stream
  Stream<Joke> get joke => _jokeController.stream;
 
 JokeCommentListBloc(this.commentJoke, {this.jokeService}){
    _jokeController.sink.add(commentJoke);
      super.getItems();
 }
 
  @override
  void dispose() {
      _jokeController.close();
  }

  @override
  Future<CommentListResponse> fetchFromServer() async{
    return  await jokeService.getComments(joke:commentJoke, page: super.currentPage);
  }

  @override
  bool itemIdentificationCondition(Comment currentComment , Comment updatedComment) {
    return currentComment.id ==updatedComment.id;
  }

  @override
  String getEmptyResultMessage() {
    
    return 'No Comments to display';
  }
}
