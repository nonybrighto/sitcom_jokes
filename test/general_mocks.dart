import 'package:mockito/mockito.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/services/movie_service.dart';


//API mock
class MockJokeService extends Mock implements JokeService{}
class MockMovieService extends Mock implements MovieService{}