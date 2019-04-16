import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/widgets/general/scroll_list.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key key}) : super(key: key);

  @override
  _MovieListPageState createState() => new _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieListBloc _movieListBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _movieListBloc = BlocProvider.of<MovieListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Sitcoms'),
      ),
      body: ScrollList<Movie>(
        scrollListType: ScrollListType.list,
        listContentStream: _movieListBloc.items,
        loadStateStream: _movieListBloc.loadState,
        loadMoreAction: () {
          _movieListBloc.getItems();
        },
        listItemWidget: (movie, index) {
          _buildMovieTile(movie);
        },
      ),
    );
  }

  _buildMovieTile(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildMovieDetails(movie),
          ),
          _buildMovieImage(movie.title),
        ],
      ),
    );
  }

  _buildMovieDetails(Movie movie) {
    return InkWell(
      splashColor: Colors.orange,
      onTap: () {
        Router.gotoMovieDetialsPage(context,
            movie: movie, movieListBloc: _movieListBloc);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          height: 140,
          padding: EdgeInsets.only(left: 135, top: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'The title',
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.favorite, color: (movie.followed)? Theme.of(context).accentColor: Theme.of(context).textTheme.body1.color,)
                ],
              ),
              Text(
                'Images(50) | Texts(500)',
                style: TextStyle(color: const Color(0XFFc0c0c0)),
              ),
              Text(
                'release date - Janruary 2017',
                style: TextStyle(color: const Color(0XFFc0c0c0)),
              ),
              Text(
                '50 folllowers',
                style: TextStyle(color: const Color(0XFFc0c0c0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('View Jokes'),
                    onPressed: () {
                      Router.gotoHomePage(context, movie: movie);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildMovieImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 120,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white30,
          image: DecorationImage(
            fit: BoxFit.fill,
            // image: CachedNetworkImageProvider('https://image.tmdb.org/t/p/w185_and_h278_bestv2/tJIWuZC4ZVUJdVHXJfefUDzS2BX.jpg')
            image: NetworkImage(imageUrl),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
