import 'dart:async';

import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:test/test.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:mockito/mockito.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


void main() {
  JokeService jokeService;
  List<Joke> sampleJokes;
  setUp(() {

    jokeService = MockJokeService();
    sampleJokes = [
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..totalComments = 21
        ..jokeType = JokeType.image
        ..movie.update((b) => b
          ..id = 'id'
          ..name = 'name'
          ..tmdbMovieId = 1
          ..description = 'desc')),

    ];
    when(jokeService.fetchAllJokes(
        jokeType: anyNamed('jokeType'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => [sampleJokes[0]]);

    when(jokeService.fetchMovieJokes(
        jokeType: anyNamed('jokeType'),
        movie: anyNamed('movie'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    )) .thenAnswer((_) async => [sampleJokes[0]]);

    when(jokeService.fetchUserFavJokes(
       jokeType: anyNamed('jokeType'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    )).thenAnswer((_) async => [sampleJokes[0]]);
  });

  // test('Expect jokes to be gotten once started', () {
  //   JokeListBloc imageJokeListBloc =
  // JokeListBloc(JokeType.image, jokeService: jokeService);

  //   expect(imageJokeListBloc.loadState, emitsAnyOf([loading, loadingMore]));
  // });

  test('Expected order when joke loading joke for first time', () {
    JokeListBloc imageJokeListBloc =
        JokeListBloc(JokeType.image, jokeService: jokeService);
        imageJokeListBloc.fetchAllJokes();
    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loaded]));
    expect(imageJokeListBloc.items, emits([sampleJokes[0]]));
  });

  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);

    imageJokeListBloc.fetchAllJokes();
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
    expect(imageJokeListBloc.items, emits([sampleJokes[0], sampleJokes[0] ]));
  });

  test('When no item to load and first trial, send load empty', (){
    JokeService jokeService = MockJokeService();
    when(jokeService.fetchAllJokes(
        jokeType: anyNamed('jokeType'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => []);

    JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loadEmpty]));

  });

  test('Expect to load error when issue from server', (){

    JokeService jokeService = MockJokeService();
    when(jokeService.fetchAllJokes(
        jokeType: anyNamed('jokeType'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => Future.error(Error()));

    JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loadError]));
  });

  test('when loading second or more page and no content, send load end', (){

    JokeService jokeService = MockJokeService();
    when(jokeService.fetchAllJokes(
        jokeType: anyNamed('jokeType'),
        page: 1,
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => [sampleJokes[0]]);

    when(jokeService.fetchAllJokes(
        jokeType: anyNamed('jokeType'),
        page: 2,
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => []);



    JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);

    imageJokeListBloc.fetchAllJokes();
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loadEnd]));
    expect(imageJokeListBloc.items, emits([sampleJokes[0]]));
  });

  test('expect to fetch user favorite jokes', ()async{

        JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);

    imageJokeListBloc.fetchUserFavoriteJokes();

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchUserFavJokes(
      jokeType: anyNamed('jokeType'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });

  test('expect to fetch movie jokes', ()async{

        JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);

    imageJokeListBloc.fetchMovieJokes( Movie((b) => b
      ..basicDetails.id = 'id $num'
      ..basicDetails.name = 'name $num'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'));

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchMovieJokes(
        jokeType: anyNamed('jokeType'),
        movie: anyNamed('movie'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });

  test('expect to fetch all jokes', ()async{

    JokeListBloc imageJokeListBloc =
    JokeListBloc(JokeType.image, jokeService: jokeService);

    imageJokeListBloc.fetchAllJokes();

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchAllJokes(
        jokeType: anyNamed('jokeType'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });
}
