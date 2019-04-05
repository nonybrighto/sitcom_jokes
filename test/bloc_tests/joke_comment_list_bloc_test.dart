import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/blocs/joke_comment_list_bloc.dart';
import 'package:sitcom_joke/models/comment_list_response.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:test/test.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:mockito/mockito.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


void main() {
  JokeService jokeService;
  Joke joke;
  BuiltList<Comment> sampleComments;
  setUp(() {

    jokeService = MockJokeService();

    joke = Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..content = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'
        ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..profileIconUrl = 'the_url'));

    sampleComments = BuiltList([
      
      Comment((u) => u
      ..id = '1'
      ..content='content'
      ..dateAdded =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = '1'
          ..username = 'John'
          ..profileIconUrl = 'the_url')
      )

    ]);
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async => CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleComments.toBuilder()));
  });

  
  test('Expect joke  to be present in joke stream', () {
  
    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    expect(commentListBloc.joke, emits(joke));
  });

  test('Expect comments to be gotten once started', () {
  
    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    expect(commentListBloc.loadState, emitsAnyOf([loading, loadingMore]));
  });

  test('Expected order when joke loading joke for first time', () {
     JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    expect(commentListBloc.loadState, emitsInOrder([loading, loaded]));
    expect(commentListBloc.items, emits(BuiltList<Comment>([sampleComments[0]])));
  });

  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    commentListBloc.getItems();

    expect(commentListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
    expect(commentListBloc.items, emits(BuiltList<Comment>([sampleComments[0], sampleComments[0] ])));
  });

  test('When no item to load and first trial, send load empty', (){
    JokeService jokeService = MockJokeService();
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async =>  CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results = BuiltList<Comment>([]).toBuilder()));

   JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    expect(commentListBloc.loadState, emitsInOrder([loading, loadEmpty]));

  });

  test('Expect to load error when issue from server', (){


     JokeService jokeService = MockJokeService();
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async => Future.error(Error()));

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    expect(commentListBloc.loadState, emitsInOrder([loading, loadError]));
  });

  test('when loading second or more page and no content, send load end', (){

    JokeService jokeService = MockJokeService();

         when(jokeService.getComments(joke: anyNamed('joke'), page: 1))
        .thenAnswer((_) async =>  CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleComments.toBuilder()));
         when(jokeService.getComments(joke: anyNamed('joke'), page: 2))
        .thenAnswer((_) async =>  CommentListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  BuiltList<Comment>([]).toBuilder()));

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    commentListBloc.getItems();

    expect(commentListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loadEnd]));
    expect(commentListBloc.items, emits([sampleComments[0]]));
  });
}
