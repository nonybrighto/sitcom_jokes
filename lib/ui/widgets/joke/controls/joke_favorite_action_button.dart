import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_control_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_action_button.dart';

class JokeFavoriteActionButton extends StatelessWidget {

  final Joke joke;
  final Color iconColor;
  final double size;
  JokeFavoriteActionButton({this.joke, this.iconColor, this.size});
  @override
  Widget build(BuildContext context) {
    JokeControlBloc jokeControlBloc = BlocProvider.of<JokeControlBloc>(context);
    return  StreamBuilder<bool>(
                  stream: BlocProvider.of<AuthBloc>(context).isAuthenticated,
                  builder: (context, isAuthenticatedSnapshot) {
                    return JokeActionButton(
                        title: 'Favorite',
                        icon: Icons.favorite,
                        selected: joke.favorited,
                        size: size,
                        onTap: () {
                          if(isAuthenticatedSnapshot.data){
                            jokeControlBloc.toggleJokeFavorite();
                          }else{
                            Router.gotoAuthPage(context, AuthType.login);
                          }
                        });
                  }
                );
  }
}