import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/ui/pages/about_page.dart';
import 'package:sitcom_joke/ui/pages/joke/add_joke_page.dart';
import 'package:sitcom_joke/ui/pages/joke/joke_display_page.dart';
import 'package:sitcom_joke/ui/pages/movie/movie_list_page.dart';
import 'package:sitcom_joke/ui/pages/settings_page.dart';

class Router{

  static gotoMoviePage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieListPage()));
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => JokeDisplayPage(initialPage: initialPage, jokeType: jokeType, jokeListBloc: jokeListBloc,)));
  }

}