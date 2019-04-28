import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_control_bloc.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/ui/widgets/joke/controls/joke_favorite_action_button.dart';
import 'package:sitcom_joke/ui/widgets/joke/controls/joke_like_action_button.dart';
import 'package:sitcom_joke/ui/widgets/joke/controls/joke_save_action_buttons.dart';
import 'package:sitcom_joke/ui/widgets/joke/controls/joke_share_action_button.dart';
import 'package:sitcom_joke/ui/widgets/user/user_profile_icon.dart';
import 'package:sitcom_joke/utils/date_formater.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final int index;
  final textJokeBoundaryKey = GlobalKey();
  JokeCard(this.index, {this.joke});
  @override
  Widget build(BuildContext context) {
    JokeListBloc jokeListBloc = BlocProvider.of<JokeListBloc>(context);
    JokeControlBloc jokeControlBloc = JokeControlBloc(
        jokeControlled: joke,
        jokeListBloc: jokeListBloc,
        jokeService: JokeService());
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildJokeHeader(context),
          _buildJokeContent(
              context: context, joke: joke, jokeListBloc: jokeListBloc),
          _buildJokeFooter(context, jokeControlBloc, joke)
        ],
      ),
    );
  }

  _buildJokeHeader(context) {
    return ListTile(
      leading: UserProfileIcon(
        user: joke.owner,
      ),
      title: Wrap(
        children: <Widget>[
          Text(
            joke.owner.username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          (joke.title != null)
              ? Wrap(
                  children: <Widget>[
                    Icon(
                      Icons.play_arrow,
                      size: 20,
                    ),
                    Text(
                      joke.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Container(),
        ],
      ),
      subtitle: Text(DateFormatter.dateToString(
          joke.dateAdded, DateFormatPattern.timeAgo)),
      trailing: _buildJokeMenuButton(context),
    );
  }

  _buildJokeMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('View Likes'),
              value: 'viewLikes',
            ),
            PopupMenuItem(
              child: Text('Report Content'),
              value: 'reportContent',
            )
          ],
      onSelected: (value) {
        switch (value) {
          case 'viewLikes':
            Router.gotoJokeLikersPage(context, joke: joke);
            break;
          case 'reportContent':
            break;
        }
      },
    );
  }

  _buildJokeContent(
      {BuildContext context, Joke joke, JokeListBloc jokeListBloc}) {
    return GestureDetector(
      onTap: () {
        jokeListBloc.changeCurrentJoke(joke);
        Router.gotoJokeDisplayPage(context,
            initialPage: index, jokeListBloc: jokeListBloc, joke: joke);
      },
      child: Column(
        children: <Widget>[
          (joke.text != null) ? _buildTextDisplay(joke.text) : Container(),
          (joke.hasImage()) ? _buildImageDisplay(joke.imageUrl) : Container(),
        ],
      ),
    );
  }

  _buildJokeFooter(
      BuildContext context, JokeControlBloc jokeControlBloc, Joke joke) {
    return Container(
        color: Colors.grey[900],
        child: BlocProvider<JokeControlBloc>(
            bloc: jokeControlBloc,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                JokeLikeActionButton(joke: joke,size: 12, showLikeCount: true,),
                JokeSaveActionButton(joke: joke, textJokeBoundaryKey: textJokeBoundaryKey, size: 12,),
                JokeFavoriteActionButton(joke: joke,size: 12,),
                JokeShareActionButton(joke: joke,size: 12,),
              ],
            )));
  }

  _buildImageDisplay(String imageUrl) {
    return SizedBox(
        width: double.infinity,
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          placeholder: 'assets/images/image_placeholder.png',
          image: imageUrl,
        ));
  }

  _buildTextDisplay(String jokeContent) {
    return RepaintBoundary(
      key: textJokeBoundaryKey,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Text(jokeContent),
      ),
    );
  }
}
