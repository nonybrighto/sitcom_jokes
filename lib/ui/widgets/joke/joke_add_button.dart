import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';

class JokeAddButton extends StatelessWidget {

  final Movie selectedMovie;
  JokeAddButton({this.selectedMovie});
  @override
  Widget build(BuildContext context) {
    return Hero(
              tag: 'joke_add',
              child: StreamBuilder<bool>(
                stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
                builder: (context, isAuthenticatedSnapshot) {
                  return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
                  //The movie is used to initialize movie on the add page if the movie jokes is being viewed instead of having to search for it
                 if(isAuthenticatedSnapshot.data){
                  Router.gotoAddJokePage(context, selectedMovie: selectedMovie); 
                 }else{
                   Router.gotoAuthPage(context, AuthType.login);
                 }
          },
        );
                }
              ),
      );
  }
}

