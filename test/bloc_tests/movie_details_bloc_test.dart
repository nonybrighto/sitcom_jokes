import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/services/movie_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';

void main() {
  MovieService movieService;
  List<Movie> sampleMovies;

  setUp(() {
    movieService = MockMovieService();

    sampleMovies = [
      Movie((b) => b
        ..basicDetails.id = 'id1'
        ..basicDetails.name = 'name ssnum'
        ..basicDetails.tmdbMovieId = 1
        ..basicDetails.followed = true
        ..basicDetails.description = 'desc'
        ..tmdbDetails.id = 1
        ..tmdbDetails.title = 'peter'
        ..tmdbDetails.backdropPath = ''
        ..tmdbDetails.overview = 'ddd'
        ..tmdbDetails.releaseDate = DateTime(2000,10,10)
        ..tmdbDetails.voteAverage = 8.9
        )
    ];

    when(movieService.getMovies(page: anyNamed('page')))
      ..thenAnswer((_) async => [sampleMovies[0]]);
  });

  test('Load movie if it is incomplete', () async{
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
          ..basicDetails.id = 'id1'
          ..basicDetails.name = 'name ssnum'
          ..basicDetails.tmdbMovieId = 1
          ..basicDetails.followed = true
          ..basicDetails.description = 'desc'
        );
    Movie fullMovieDetails = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = true
      ..basicDetails.description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet))
        .thenAnswer((_) async => fullMovieDetails);

    MovieDetialsBloc movieDetialsBloc =
        MovieDetialsBloc(movieService: movieService, currentMovie: movieToGet);
    expect(movieDetialsBloc.loadState, emitsInOrder([loading, loaded]));
    expect(
        movieDetialsBloc.movie, emitsInOrder([movieToGet, fullMovieDetails]));
  });

  test('Dont load movie if it is complete', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = true
      ..basicDetails.description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );

    when(movieService.getMovie(movieToGet)).thenAnswer((_) async => movieToGet);

    MovieDetialsBloc movieDetialsBloc =
        MovieDetialsBloc(movieService: movieService, currentMovie: movieToGet);
    expect(movieDetialsBloc.loadState, emits(loaded));
    expect(movieDetialsBloc.movie, emits(movieToGet));

    verifyNever(movieService.getMovie(movieToGet));
  });

  test('swap moviefollow state when follow changed', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = true
      ..basicDetails.description = 'desc');
    Movie fullMovieDetails = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = true
      ..basicDetails.description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );
    Movie fullMovieDetailsSwappedFav = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'
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
            movieId: anyNamed('movieId'),
            userId: anyNamed('userId'),
            follow: anyNamed('follow')))
        .thenAnswer((_) async => null);

    MovieDetialsBloc movieDetialsBloc =
        MovieDetialsBloc(movieService: movieService, currentMovie: movieToGet);

    await Future.delayed(Duration(seconds: 2));
    movieDetialsBloc.changeMovieFollow((_) {});

    expect(
        movieDetialsBloc.movie,
        emitsInOrder(
            [
             // movieToGet,  // Don't know why, but each Future.delay prevent one item from being emmited in BehaviorSubject. works with streamController
              fullMovieDetails, 
              fullMovieDetailsSwappedFav]));
    await Future.delayed(Duration(seconds: 2));
    verify(movieService.changeMovieFollow(
        movieId: anyNamed('movieId'),
        userId: anyNamed('userId'),
        follow: anyNamed('follow')));
  });

  test('revert swap if error in service and call error callback', () async {
    MovieService movieService = MockMovieService();

    Movie movieToGet = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = true
      ..basicDetails.description = 'desc');
    Movie fullMovieDetails = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = true
      ..basicDetails.description = 'desc'
      ..tmdbDetails.id = 1
      ..tmdbDetails.title = 'peter'
      ..tmdbDetails.backdropPath = ''
      ..tmdbDetails.overview = 'ddd'
      ..tmdbDetails.releaseDate = DateTime(2000,10,10)
      ..tmdbDetails.voteAverage = 8.9
      );
    Movie fullMovieDetailsSwappedFav = Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.name = 'name ssnum'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.followed = false
      ..basicDetails.description = 'desc'
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
            movieId: anyNamed('movieId'),
            userId: anyNamed('userId'),
            follow: anyNamed('follow')))
        .thenAnswer((_) => Future.error(Error()));

    MovieDetialsBloc movieDetialsBloc =
        MovieDetialsBloc(movieService: movieService, currentMovie: movieToGet);

    await Future.delayed(Duration(seconds: 2));

    bool errorCallbackCalled = false;
    movieDetialsBloc.changeMovieFollow((_) {
          errorCallbackCalled = true;
    });

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
        movieId: anyNamed('movieId'),
        userId: anyNamed('userId'),
        follow: anyNamed('follow')));

    expect(errorCallbackCalled, true);
  });
}
