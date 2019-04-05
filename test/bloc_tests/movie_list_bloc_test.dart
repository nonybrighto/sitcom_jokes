import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/movie/movie_list_response.dart';
import 'package:sitcom_joke/services/movie_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';


void main(){


  MovieService movieService;
  BuiltList<Movie> sampleMovies;

  setUp((){

     movieService = MockMovieService();

      sampleMovies = BuiltList([
        Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.title = 'name ssnum'
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
      ]);

      when(movieService.getMovies(page: anyNamed('page')))..thenAnswer((_) async =>MovieListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  sampleMovies.toBuilder()));

  });

  // test('Expect jokes to be gotten once started', () {
  //   MovieListBloc movieListBloc =
  //     MovieListBloc(movieService: movieService);

  //   expect(movieListBloc.loadState, emitsAnyOf([loading, loadingMore]));
  // });

  
  test('when loading the second time, expect state to be loading more and list should contain two items',() async{

    MovieListBloc movieListBloc =
      MovieListBloc(movieService: movieService);

    movieListBloc.getItems();

    expect(movieListBloc.loadState, emitsInOrder([loading, loaded, loadingMore, loaded]));
    expect(movieListBloc.items, emits([sampleMovies[0], sampleMovies[0] ]));
  });



  test('Movie content can be updated', () async{

      MovieListBloc movieListBloc =MovieListBloc(movieService: movieService);

      await Future.delayed(Duration(seconds: 5));
     
       Movie movieUpdate =  Movie((b) => b
      ..basicDetails.id = 'id1'
      ..basicDetails.title = 'name  new'
      ..basicDetails.tmdbMovieId = 1
      ..basicDetails.description = 'desc new');

      movieListBloc.updateItem(movieUpdate);
      expect(movieListBloc.items, emits([movieUpdate]));
    
  });
}