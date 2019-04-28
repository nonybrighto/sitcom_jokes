import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_control_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_action_button.dart';
import 'package:sitcom_joke/utils/joke_save_util.dart';

class JokeSaveActionButton extends StatelessWidget {

  final GlobalKey textJokeBoundaryKey;
  final Joke joke;
  final double size;
  final Color iconColor;
  JokeSaveActionButton({this.textJokeBoundaryKey, this.joke, this.size, this.iconColor});
  @override
  Widget build(BuildContext context) {
    JokeControlBloc jokeControlBloc = BlocProvider.of<JokeControlBloc>(context);
    return StreamBuilder<LoadState>(
                    initialData: Loaded(),
                    stream: jokeControlBloc.jokeSaveLoadState,
                    builder: (context, jokeSaveLoadStateSnapshot) {
                      String extraSaveText =
                          (jokeSaveLoadStateSnapshot.data is Loading)
                              ? '...'
                              : '';
                      return JokeActionButton(
                          title: 'Save' + extraSaveText,
                          icon: Icons.arrow_downward,
                          selected: false,
                          size: size,
                          onTap: () async {
                            if (joke.hasImage()) {
                              jokeControlBloc.saveImageJoke((message) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(message),
                                ));
                              });
                            } else {
                              jokeControlBloc.saveTextJoke(
                                  await JokeSaveUtil()
                                      .textToImage(textJokeBoundaryKey),
                                  (message) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(message),
                                ));
                              });
                            }
                          });
                    });
  }
}