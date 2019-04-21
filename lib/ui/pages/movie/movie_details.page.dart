import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:sitcom_joke/models/movie/tmdb_movie_cast.dart';
import 'package:sitcom_joke/ui/widgets/buttons/general_buttons.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/ui/widgets/general/main_error_display.dart';
import 'package:sitcom_joke/ui/widgets/general/minor.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  final MovieListBloc movieListBloc;
  MovieDetailsPage({Key key, this.movie, this.movieListBloc}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => new _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetialsBloc movieDetialsBloc;
  BuildContext _context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieDetialsBloc = BlocProvider.of<MovieDetialsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LoadState>(
        initialData: Loading(),
        stream: movieDetialsBloc.loadState,
        builder:
            (BuildContext context, AsyncSnapshot<LoadState> loadStateSnapshot) {
          LoadState loadState = loadStateSnapshot.data;
          _context = context;
          return StreamBuilder<Movie>(
            initialData: widget.movie,
            stream: movieDetialsBloc.movie,
            builder:
                (BuildContext context, AsyncSnapshot<Movie> movieSnapshot) {
              Movie movie = movieSnapshot.data;
               _updateMovieInList(movie);

              return SliverFab(
                floatingActionButton:
                    _movieFollowButton(true), //TODO: change to movie.followed,
                expandedHeight: 256.0,
                slivers: <Widget>[
                  new SliverAppBar(
                    expandedHeight: 256.0,
                    pinned: true,
                    flexibleSpace: new FlexibleSpaceBar(
                      title: new Text("Friends"),
                      centerTitle: true,
                      background: new Image.asset(
                        "assets/images/header_bg.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _buildMovieBasicDetailsBox(movie),
                      (true /** if loaded */)
                          ? _buildMovieCasts(null)
                          : _buildProgress(
                              LoadError('message')), //TODO: put casts  and set loading
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

  _buildProgress(LoadState loadState) {
   
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: (loadState is Loading)? CircularProgressIndicator() : MainErrorDisplay(
            errorMessage: (loadState as LoadError).message,
            buttonText: 'RETRY',
            onErrorButtonTap: () {
              movieDetialsBloc.getMovieDetails();
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
            Text('''ddddd   dddddd ddddddddddd ddddddd dddd dd ddddd   dddddd ddddddddddd ddddddd dddd dd ddddd   dddddd ddddddddddd ddddddd dddd dd''',
                style: TextStyle(
                  color: Colors.grey,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Comedy'),
                Text('Comedy'),
                Text('Comedy'),
              ],
            )
          ],
        ),
      ),
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
            _countDetailBox('IMAGES', 1000),
            Divider(color: Colors.grey[300]),
            _countDetailBox('TEXTS', 9000),
            Divider(color: Colors.grey[300]),
            _countDetailBox('FOLLOWERS', 20000),
          ],
        ),
      ),
    );
  }

  _buildMovieCasts(List<TmdbMovieCast> movieCasts) {
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
            itemCount: 20, //TODO: Change to cast.legth
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildCastDetails(null); //
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
                image: DecorationImage(image: NetworkImage('url'))),
          ),
          Text(
            'Charlie Sheen',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            '(Charlie Harper)',
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

  _movieFollowButton(bool movieFollowed) {
    return RoundedButton(
      child: Row(
        children: <Widget>[
          Icon((movieFollowed) ? Icons.favorite : Icons.file_upload),
          SizedBox(
            width: 10,
          ),
          Text(
            (movieFollowed) ? 'FOLLOWING' : 'FOLLOW',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
      onPressed: () {
        movieDetialsBloc.changeMovieFollow((errorMessage) {
          _onMovieFollowError(errorMessage);
        });
      },
    );
  }

  _onMovieFollowError(String errorMessage) {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text(errorMessage),
    ));
  }

  _updateMovieInList(Movie movie){

    if(widget.movieListBloc != null && !movie.hasFullDetails()){
        widget.movieListBloc.updateItem(movie);
    }

  }
}
