import 'package:mockito/mockito.dart';
import 'package:sitcom_joke/blocs/joke_add_bloc.dart';
import 'package:sitcom_joke/models/bloc_delegate.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


String errorMessage;
class DelegateMock extends BlocDelegate<Joke>{
  @override
  error(String message) {
    errorMessage = message;
  }

  @override
  success(Joke joke) {
    //successUser = user;
  }
 

}

void main(){

   JokeService jokeService;
  List<Joke> sampleJokes;
  setUp(() {

    jokeService = MockJokeService();
    sampleJokes = [
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
          ..profileIconUrl = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22)),

    ];

    when(jokeService.addJoke(joke:anyNamed('joke'), imageToUpload: anyNamed('imageToUpload')))
        .thenAnswer((_) async => sampleJokes[0]);
  });



  test('expect to save joke successfully', ()async{

    DelegateMock delegateMock = new DelegateMock();
    JokeAddBloc jokeAddBloc = JokeAddBloc(jokeService: jokeService, delegate: delegateMock);

    jokeAddBloc.addJoke(sampleJokes[0], null);
    expect(jokeAddBloc.loadState, emitsInOrder([loaded, loading, loaded]));
    await Future.delayed(Duration(seconds: 3));
    verify(jokeService.addJoke(joke:anyNamed('joke'), imageToUpload: anyNamed('imageToUpload')));
  });

  test('expect to return error when joke add fails', ()async{

    when(jokeService.addJoke(joke:anyNamed('joke'), imageToUpload: anyNamed('imageToUpload')))
        .thenAnswer((_) async =>  Future.error('error occured'));

    DelegateMock delegateMock = new DelegateMock();
    JokeAddBloc jokeAddBloc = JokeAddBloc(jokeService: jokeService, delegate: delegateMock);

    jokeAddBloc.addJoke(sampleJokes[0], null);
    expect(jokeAddBloc.loadState, emitsInOrder([loaded, loading, loadError]));
    await Future.delayed(Duration(seconds: 3));
    expect(errorMessage, 'error occured');
    verify(jokeService.addJoke(joke:anyNamed('joke'), imageToUpload: anyNamed('imageToUpload')));
  });
}