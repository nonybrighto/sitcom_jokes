import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_comment_list_bloc.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/services/movie_service.dart';
import 'package:sitcom_joke/ui/pages/about_page.dart';
import 'package:sitcom_joke/ui/pages/joke/add_joke_page.dart';
import 'package:sitcom_joke/ui/pages/joke/joke_comments_page.dart';
import 'package:sitcom_joke/ui/pages/joke/joke_display_page.dart';
import 'package:sitcom_joke/ui/pages/movie/movie_details.page.dart';
import 'package:sitcom_joke/ui/pages/movie/movie_list_page.dart';
import 'package:sitcom_joke/ui/pages/settings_page.dart';

class Router{

  static gotoMoviePage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<MovieListBloc>(
          bloc: MovieListBloc(movieService:  MovieService()),
          child: MovieListPage(),
        )));
  }
  static gotoMovieDetialsPage(BuildContext context, {Movie movie, MovieListBloc movieListBloc}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<MovieDetialsBloc>(
          bloc: MovieDetialsBloc(movieToget: movie, movieService:  MovieService()),
          child: MovieDetailsPage(movie: movie, movieListBloc: movieListBloc,),
        )));
  }
  static gotoAddJokePage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddJokePage()));
  }
  static gotoSettingsPage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
  }
  static gotoAboutPage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutPage()));
  }

  static gotoJokeDisplayPage(BuildContext context, {int initialPage, JokeType jokeType, JokeListBloc jokeListBloc}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeListBloc>(
      bloc: jokeListBloc,
      child: JokeDisplayPage(initialPage: initialPage, jokeType: jokeType),)));
  }

  static gotoJokeCommentsPage(BuildContext context, {Joke joke}){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeCommentListBloc>(
          bloc: JokeCommentListBloc(joke, jokeService: JokeService()),
          child: JokeCommentPage(),
        )));
  }

}