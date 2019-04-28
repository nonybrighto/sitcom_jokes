import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/movie_control_bloc.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_cast.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/services/movie_service.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';
import 'package:sitcom_joke/ui/widgets/buttons/general_buttons.dart';
import 'package:sitcom_joke/utils/date_formater.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/ui/widgets/general/main_error_display.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  MovieDetailsPage({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => new _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetailsBloc movieDetailsBloc;
  MovieControlBloc movieControlBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieDetailsBloc = BlocProvider.of<MovieDetailsBloc>(context);
    movieControlBloc = MovieControlBloc(
        movieControlled: widget.movie,
        movieDetailsBloc: movieDetailsBloc,
        movieListBloc: movieDetailsBloc.movieListBloc,
        movieService: MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LoadState>(
        initialData: Loading(),
        stream: movieDetailsBloc.loadState,
        builder:
            (BuildContext context, AsyncSnapshot<LoadState> loadStateSnapshot) {
          LoadState loadState = loadStateSnapshot.data;
          return StreamBuilder<Movie>(
            initialData: widget.movie,
            stream: movieDetailsBloc.movie,
            builder:
                (BuildContext context, AsyncSnapshot<Movie> movieSnapshot) {
              Movie movie = movieSnapshot.data;

              return SliverFab(
                floatingActionButton:
                    _movieFollowButton(movie.followed, loadState),
                expandedHeight: 256.0,
                slivers: <Widget>[
                  new SliverAppBar(
                    expandedHeight: 256.0,
                    pinned: true,
                    flexibleSpace: new FlexibleSpaceBar(
                      title: Text(movie.title),
                      centerTitle: true,
                      background: (movie.hasFullDetails())
                          ? Image.network(
                              movie.tmdbDetails.getBackdropUrl(),
                              fit: BoxFit.cover,
                            )
                          : _buildBackDropPlaceHolder(movie.posterUrl),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _buildMovieBasicDetailsBox(movie),
                      (loadState is Loaded)
                          ? _buildMovieCasts(movie.tmdbDetails.credits.cast)
                          : _buildProgress(loadState),
                    ]),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  _buildBackDropPlaceHolder(String posterUrl) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: Colors.white30,
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(posterUrl))),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(color: Colors.black.withOpacity(0.5)),
        )
      ],
    );
  }

  _buildProgress(LoadState loadState) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: (loadState is Loading)
            ? CircularProgressIndicator()
            : MainErrorDisplay(
                errorMessage: (loadState as LoadError).message,
                buttonText: 'RETRY',
                onErrorButtonTap: () {
                  movieDetailsBloc.getMovieDetails();
                },
              ),
      ),
    );
  }

  _buildMovieBasicDetailsBox(Movie movie) {
    return Stack(
      children: <Widget>[
        _buildMovieDescriptions(movie),
        _buildMovieContentCount(movie)
      ],
    );
  }

  _buildMovieDescriptions(Movie movie) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 90, top: 10, bottom: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('details',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                (movie.hasFullDetails() ? movie.tmdbDetails.overview : ''),
              ),
            ),
            _buildPointDetail(
                'Release Date',
                DateFormatter.dateToString(
                    movie.releaseDate, DateFormatPattern.wordDate)),
            _buildPointDetail(
                'Vote average',
                (movie.hasFullDetails())
                    ? movie.tmdbDetails.voteAverage.toString()
                    : 'N/A'),
            _buildPointDetail(
                'Genres',
                (movie.hasFullDetails())
                    ? movie.tmdbDetails.getGenreCsv()
                    : 'N/A'),
          ],
        ),
      ),
    );
  }

  _buildPointDetail(String title, String detail) {
    return Row(
      children: <Widget>[
        Text(title,
            style: TextStyle(
                color: Colors.grey[300], fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Text('-'),
        ),
        Text(detail, style: TextStyle(color: Colors.grey[300])),
      ],
    );
  }

  _buildMovieContentCount(Movie movie) {
    return Positioned(
      top: 0,
      bottom: 0,
      width: 80,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _countDetailBox('JOKES', movie.jokeCount),
            Divider(color: Colors.grey[300]),
            _countDetailBox('FOLLOWERS', movie.followerCount),
          ],
        ),
      ),
    );
  }

  _buildMovieCasts(BuiltList<TmdbMovieCast> movieCasts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Movie Casts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: movieCasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildCastDetails(movieCasts[index]);
            },
          ),
        )
      ],
    );
  }

  _buildCastDetails(TmdbMovieCast movieCast) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 120,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white24,
              image: (movieCast.getProfileUrl() != null)
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(movieCast.getProfileUrl()))
                  : null,
            ),
          ),
          Text(
            movieCast.name,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            '(${movieCast.character})',
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
          )
        ],
      ),
    );
  }

  _countDetailBox(String detail, int count) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.black),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      ],
    );
  }

  _movieFollowButton(bool movieFollowed, LoadState loadState) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
        builder: (BuildContext context,
            AsyncSnapshot<bool> isAuthenticatedSnapshot) {
          return RoundedButton(
            child: (loadState is Loaded)
                ? Row(
                    children: <Widget>[
                      Icon(
                          (movieFollowed) ? Icons.favorite : Icons.file_upload),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        (movieFollowed) ? 'FOLLOWING' : 'FOLLOW',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                : CircularProgressIndicator(),
            onPressed: (loadState is Loaded)
                ? () {
                    if (isAuthenticatedSnapshot.data) {
                      movieControlBloc.toggleMovieFollow();
                    } else {
                      Router.gotoAuthPage(context, AuthType.login);
                    }
                  }
                : null,
          );
        });
  }
}
