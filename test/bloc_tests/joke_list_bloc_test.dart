import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/models/joke_list_response.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:test/test.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:mockito/mockito.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


void main() {
  JokeService jokeService;
  BuiltList<Joke> sampleJokes;
  setUp(() {

    jokeService = MockJokeService();
    sampleJokes = BuiltList([
      Joke((b) => b
        ..id = 'id$num'
        ..title = 'user joke $num'
        ..text = 'user Joke'
        ..commentCount = 21
        ..likeCount = 1
        ..liked = false
        ..favorited = false
        ..dateAdded = DateTime(2003)
        ..movie.id = 'movid $num'
        ..movie.title = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'
         ..owner.update((u) => u
          ..id = '1 $num'
          ..username = 'John $num'
          ..photoUrl = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22)),

    ]);
    when(jokeService.fetchAllJokes(
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleJokes.toBuilder()));

    when(jokeService.fetchMovieJokes(
        movie: anyNamed('movie'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    )) .thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleJokes.toBuilder()));

    when(jokeService.fetchUserJokes(
        user: anyNamed('user'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    )) .thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleJokes.toBuilder()));

    when(jokeService.fetchUserFavJokes(
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    )).thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleJokes.toBuilder()));
  });

  test('Expected order when joke loading joke for first time', () {
    JokeListBloc imageJokeListBloc =
        JokeListBloc( jokeService: jokeService);
        imageJokeListBloc.fetchAllJokes();
    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loaded]));
    expect(imageJokeListBloc.items, emits(sampleJokes.toList()));
  });

  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);

    imageJokeListBloc.fetchAllJokes();
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
     var jokeBuilder = sampleJokes.toBuilder()..addAll(sampleJokes.toList());
     expect(imageJokeListBloc.items, emits(jokeBuilder.build()));
  });

  test('When no item to load and first trial, send load empty', (){
    JokeService jokeService = MockJokeService();
    when(jokeService.fetchAllJokes(
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results = BuiltList<Joke>([]).toBuilder()));

    JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loadEmpty]));

  });

  test('Expect to load error when issue from server', (){

    JokeService jokeService = MockJokeService();
    when(jokeService.fetchAllJokes(
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => Future.error(Error()));

    JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loadError]));
  });

  test('when response current page is same as total page, send load end', (){

    JokeService jokeService = MockJokeService();
    when(jokeService.fetchAllJokes(
        page: 1,
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleJokes.toBuilder()));

    when(jokeService.fetchAllJokes(
        page: 2,
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')))
        .thenAnswer((_) async => JokeListResponse((b) => b..totalPages = 2..currentPage = 2 ..perPage = 10 ..results = sampleJokes.toBuilder()));



    JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);

    imageJokeListBloc.fetchAllJokes();
    imageJokeListBloc.fetchAllJokes();

    expect(imageJokeListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loadEnd]));
  });

  test('expect to fetch user favorite jokes', ()async{

        JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);

    imageJokeListBloc.fetchUserFavoriteJokes();

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchUserFavJokes(
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });

  test('expect to fetch movie jokes', ()async{

        JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);

    imageJokeListBloc.fetchMovieJokes( Movie((b) => b
      ..id = 'id $num'
      ..title = 'name $num'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'));

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchMovieJokes(
        movie: anyNamed('movie'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });

  test('expect to fetch all jokes', ()async{

    JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);

    imageJokeListBloc.fetchAllJokes();

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchAllJokes(
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });
  test('expect to fetch user jokes', ()async{

    JokeListBloc imageJokeListBloc =
    JokeListBloc( jokeService: jokeService);

    imageJokeListBloc.fetchUserJokes(User((b) => b
      ..id='id'
      ..username='peter'
      ..photoUrl='url'
       ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22
    ));

     await Future.delayed(Duration(seconds: 2));

    verify(jokeService.fetchUserJokes(
        user: anyNamed('user'),
        page: anyNamed('page'),
        sortOrder: anyNamed('sortOrder'),
        jokeSortProperty: anyNamed('jokeSortProperty')
    ));
  });
}
