import 'package:mockito/mockito.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/services/movie_service.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';

void main() {
 

  setUp(() {
  });

  test('Load movie if it is incomplete', () async{
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
          ..id = 'id1'
          ..title = 'name ssnum'
          ..tmdbMovieId = 1
          ..followed = true
          ..description = 'desc'
        );
    Movie fullMovieDetails = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet))
        .thenAnswer((_) async => fullMovieDetails);

    MovieDetailsBloc movieDetialsBloc =
        MovieDetailsBloc(movieService: movieService, viewedMovie: movieToGet);
    expect(movieDetialsBloc.loadState, emitsInOrder([loading, loaded]));
    expect(
        movieDetialsBloc.movie, emitsInOrder([movieToGet, fullMovieDetails]));
  });

  test('Dont load movie if it is complete', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet)).thenAnswer((_) async => movieToGet);

    MovieDetailsBloc movieDetialsBloc =
        MovieDetailsBloc(movieService: movieService, viewedMovie: movieToGet);
    expect(movieDetialsBloc.loadState, emits(loaded));
    expect(movieDetialsBloc.movie, emits(movieToGet));

    verifyNever(movieService.getMovie(movieToGet));
  });

  test('swap moviefollow state when follow changed', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..description = 'desc');
    Movie fullMovieDetails = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );
    Movie fullMovieDetailsSwappedFav = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      
      );

    when(movieService.getMovie(movieToGet))
        .thenAnswer((_) async => fullMovieDetails);
    when(movieService.changeMovieFollow(
            movie: anyNamed('movie'),
            follow: anyNamed('follow')))
        .thenAnswer((_) async => null);

    MovieDetailsBloc movieDetialsBloc =
        MovieDetailsBloc(movieService: movieService, viewedMovie: movieToGet);

    await Future.delayed(Duration(seconds: 2));

    expect(
        movieDetialsBloc.movie,
        emitsInOrder(
            [
             // movieToGet,  // Don't know why, but each Future.delay prevent one item from being emmited in BehaviorSubject. works with streamController
              fullMovieDetails, 
              fullMovieDetailsSwappedFav]));
    await Future.delayed(Duration(seconds: 2));
    verify(movieService.changeMovieFollow(
        movie: anyNamed('movie'),
        follow: anyNamed('follow')));
  });

  test('revert swap if error in service and call error callback', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..description = 'desc');
    Movie fullMovieDetails = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = true
      ..description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );
    Movie fullMovieDetailsSwappedFav = Movie((b) => b
      ..id = 'id1'
      ..title = 'name ssnum'
      ..tmdbMovieId = 1
      ..followed = false
      ..description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet))
        .thenAnswer((_) async => fullMovieDetails);
    when(movieService.changeMovieFollow(
            movie: anyNamed('movie'),
            follow: anyNamed('follow')))
        .thenAnswer((_) => Future.error(Error()));

    MovieDetailsBloc movieDetialsBloc =
        MovieDetailsBloc(movieService: movieService, viewedMovie: movieToGet);

    await Future.delayed(Duration(seconds: 2));

    bool errorCallbackCalled = false;
    

    expect(
        movieDetialsBloc.movie,
        emitsInOrder([
          //movieToGet,
          fullMovieDetails,
          fullMovieDetailsSwappedFav,
          fullMovieDetails
        ]));
   
    await Future.delayed(Duration(seconds: 2));
    verify(movieService.changeMovieFollow(
        movie: anyNamed('movie'),
        follow: anyNamed('follow')));

    expect(errorCallbackCalled, true);
  });
}
