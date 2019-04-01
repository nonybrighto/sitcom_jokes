import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_comment_list_bloc.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/blocs/movie_details_bloc.dart';
import 'package:sitcom_joke/blocs/movie_list_bloc.dart';
import 'package:sitcom_joke/blocs/user_details_bloc.dart';
import 'package:sitcom_joke/blocs/user_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/services/movie_service.dart';
import 'package:sitcom_joke/services/user_service.dart';
import 'package:sitcom_joke/ui/pages/about_page.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';
import 'package:sitcom_joke/ui/pages/joke/joke_add_page.dart';
import 'package:sitcom_joke/ui/pages/joke/joke_comments_page.dart';
import 'package:sitcom_joke/ui/pages/joke/joke_display_page.dart';
import 'package:sitcom_joke/ui/pages/movie/movie_details.page.dart';
import 'package:sitcom_joke/ui/pages/movie/movie_list_page.dart';
import 'package:sitcom_joke/ui/pages/settings_page.dart';
import 'package:sitcom_joke/ui/pages/user/user_details_page.dart';
import 'package:sitcom_joke/ui/pages/user/user_list_page.dart';

class Router{


  static gotoUserDetailsPage(BuildContext context, User user){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<UserDetailsBloc>(
          bloc: UserDetailsBloc(userService: UserService(), currentUser: user),
          child: UserDetailsPage(user: user,),
        )));

  }

  static gotoMoviePage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<MovieListBloc>(
          bloc: MovieListBloc(movieService:  MovieService()),
          child: MovieListPage(),
        )));
  }
  static gotoMovieDetialsPage(BuildContext context, {Movie movie, MovieListBloc movieListBloc}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<MovieDetialsBloc>(
          bloc: MovieDetialsBloc(currentMovie: movie, movieService:  MovieService()),
          child: MovieDetailsPage(movie: movie, movieListBloc: movieListBloc,),
        )));
  }
  static gotoAuthPage(BuildContext context, AuthType authType){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthPage(authType)));
  }
  static gotoAddJokePage(BuildContext context, {JokeType jokeType, Movie selectedMovie}){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => JokeAddPage(jokeType: jokeType, selectedMovie: selectedMovie,)));
  }
  static gotoSettingsPage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
  }
  static gotoAboutPage(BuildContext context){
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutPage()));
  }

  static gotoJokeDisplayPage(BuildContext context, {int initialPage, JokeType jokeType, JokeListBloc jokeListBloc, Joke joke}){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeListBloc>(
      bloc: jokeListBloc,
      child: JokeDisplayPage(initialPage: initialPage, jokeType: jokeType, currentJoke: joke,),)));
  }

  static gotoJokeCommentsPage(BuildContext context, {Joke joke}){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<JokeCommentListBloc>(
          bloc: JokeCommentListBloc(joke, jokeService: JokeService()),
          child: JokeCommentPage(),
        )));
  }
  static gotoJokeLikersPage(BuildContext context, {Joke joke}){

        UserListBloc userListBloc = UserListBloc(userService: UserService());
        userListBloc.fetchJokeLikers(joke);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlocProvider<UserListBloc>(
          bloc: userListBloc,
          child: UserListPage(),
        )));
  }

}