import 'package:flutter/material.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/navigation/router.dart';

class JokeAddButton extends StatelessWidget {

  final Movie selectedMovie;
  JokeAddButton({this.selectedMovie});
  @override
  Widget build(BuildContext context) {
    return Hero(
              tag: 'joke_add',
              child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
              //The movie is used to initialize movie on the add page if the movie jokes is being viewed instead of having to search for it
              Router.gotoAddJokePage(context, selectedMovie: selectedMovie); 
          },
        ),
      );
  }
}

