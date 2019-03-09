import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/ui/widgets/general/main_error_widget.dart';
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
          builder: (BuildContext context , AsyncSnapshot<LoadState> loadStateSnapshot){

                LoadState loadState = loadStateSnapshot.data;

               return StreamBuilder<Movie>(
                  initialData: widget.movie,
                    stream: movieDetialsBloc.movie,
                    builder: (BuildContext context, AsyncSnapshot<Movie> movieSnapshot){

                          Movie movie =movieSnapshot.data;
                          _updateMovieInList(movie);

                          return Column(children: <Widget>[

                                Text(movie.basicDetails.name),
                                RaisedButton(child: Text(movie.basicDetails.followed? 'UNFOLLOW': 'FOLLOW'), onPressed: (){
                                      movieDetialsBloc.changeMovieFollow((errorMessage){
                                        _onMovieFollowError(context, errorMessage);
                                      });
                                },),

                                _showLoading(visible: loadState is Loading),
                                _showFullInfo(movie, visible: loadState is Loaded),
                                _showError(visible: loadState is LoadError),


                          ],);
                    },
                );

          },
      ),
    );
  }

  _onMovieFollowError(BuildContext context, String errorMessage){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMessage),));
  }

  _updateMovieInList(Movie movie){

    if(widget.movieListBloc != null && !movie.hasFullDetails()){
        widget.movieListBloc.updateItem(movie);
    }

  }

  _showFullInfo(Movie movie, {bool visible}){

        if(visible){
          return Text(movie.basicDetails.description);
        }
        return containerPlaceHolder();
  }

  _showLoading({bool visible}){

        if(visible){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return containerPlaceHolder();
  }
  _showError({bool visible}){

    if(visible){
      return MainErrorWidget(errorMessage: 'Failed to load',buttonText: 'RETRY LOADING', errorTap: (){

        movieDetialsBloc.getMovieDetails();
      },);
    }
    return containerPlaceHolder();
  }
}