import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_control_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_action_button.dart';

class JokeLikeActionButton extends StatelessWidget {

  final Joke joke;
  final Color iconColor;
  final double size;
  final bool showLikeCount;
  JokeLikeActionButton({this.joke, this.iconColor, this.size, this.showLikeCount = false});
  @override
  Widget build(BuildContext context) {
    JokeControlBloc jokeControlBloc = BlocProvider.of<JokeControlBloc>(context);
    String likeCountText = (showLikeCount)?'(${joke.likeCount})':'';
    return  JokeActionButton(
                title: 'Likes '+likeCountText,
                icon: Icons.thumb_up,
                iconColor: iconColor,
                selected: joke.liked,
                size: size,
                onTap: () {
                  jokeControlBloc.toggleJokeLike();
                });
  }
}