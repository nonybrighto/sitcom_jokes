import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
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

      appBar: AppBar(title: Text('All Sitcoms'),),
      body: ScrollList<Movie>(
      scrollListType: ScrollListType.list,
      listContentStream: _movieListBloc.items,
      loadStateStream: _movieListBloc.loadState,
      loadMoreAction: (){
        _movieListBloc.getItems();
      },
      listItemWidget: (movie, index){
        return ListTile(title: Container(height: 30.0, child: Text(movie.basicDetails.title)), trailing: Text('dd'), onTap: (){
          Router.gotoMovieDetialsPage(context, movie: movie, movieListBloc: _movieListBloc);
        },);
      },

    ),
    );
  }
}