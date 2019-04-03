import 'dart:async';

import 'package:sitcom_joke/blocs/joke_comment_list_bloc.dart';
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
  List<Comment> sampleComments;
  setUp(() {

    jokeService = MockJokeService();

    joke = Joke((b) => b
      ..id = 'id'
      ..title = 'title'
      ..content = 'content'
      ..totalComments = 22
      ..jokeType = JokeType.image
      ..movie.update((b) => b
        ..id = 'id'
        ..name = 'name'
        ..tmdbMovieId = 1
        ..description = 'desc'));

    sampleComments = [
      
      Comment((u) => u
      ..id = '1'
      ..content='content'
      ..dateAdded =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = '1'
          ..username = 'John'
          ..profileIconUrl = 'the_url')
      )

    ];
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async => [sampleComments[0]]);
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
    expect(commentListBloc.items, emits([sampleComments[0]]));
  });

  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);

    commentListBloc.getItems();

    expect(commentListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
    expect(commentListBloc.items, emits([sampleComments[0], sampleComments[0] ]));
  });

  test('When no item to load and first trial, send load empty', (){
    JokeService jokeService = MockJokeService();
    when(jokeService.getComments(joke: anyNamed('joke'), page: anyNamed('page')))
        .thenAnswer((_) async => []);

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
        .thenAnswer((_) async => [sampleComments[0]]);
         when(jokeService.getComments(joke: anyNamed('joke'), page: 2))
        .thenAnswer((_) async => []);

    JokeCommentListBloc commentListBloc = JokeCommentListBloc(joke, jokeService: jokeService);
    commentListBloc.getItems();

    expect(commentListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loadEnd]));
    expect(commentListBloc.items, emits([sampleComments[0]]));
  });
}
