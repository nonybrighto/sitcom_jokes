import 'package:sitcom_joke/blocs/user_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/user_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';



void main(){

   UserService userService;
  List<User> sampleUsers;
  setUp(() {

    userService = MockUserService();
    sampleUsers = [
      User((b) => b
      ..id='id $num'
      ..name='peter $num'
      ..profileIconUrl='url $num'
    )
    ];

    when(userService.fetchJokeLikers(jokeLiked: anyNamed('jokeLiked')))
        .thenAnswer((_) async => [sampleUsers[0]]);
  });



  test('expect to fetch movie jokes', ()async{

        UserListBloc userListBloc =
    UserListBloc(userService: userService);

    userListBloc.fetchJokeLikers(Joke((b) => b
        ..id = 'id'
        ..title = 'fav Joke $num'
        ..content = 'fav Joke'
        ..totalComments = 21
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id = 'movid $num'
        ..movie.name = 'movie name $num'
        ..movie.tmdbMovieId = 1
        ..movie.description = 'description'));

     await Future.delayed(Duration(seconds: 2));

    verify(userService.fetchJokeLikers(jokeLiked: anyNamed('jokeLiked')));
  });
}