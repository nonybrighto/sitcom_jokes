import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_control_bloc.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_action_button.dart';
import 'package:zoomable_image/zoomable_image.dart';

class JokeDisplayPage extends StatefulWidget {
  final int initialPage;
  final Joke currentJoke;
  JokeDisplayPage({Key key, this.initialPage, this.currentJoke})
      : super(key: key);

  @override
  _JokeDisplayPageState createState() => new _JokeDisplayPageState();
}

class _JokeDisplayPageState extends State<JokeDisplayPage> {
  JokeListBloc jokeListBloc;
  JokeControlBloc jokeControlBloc;
  PageController _pageController;

  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _pageController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    jokeListBloc = BlocProvider.of<JokeListBloc>(context);
    jokeControlBloc = JokeControlBloc(
        jokeControlled: widget.currentJoke,
        jokeListBloc: jokeListBloc,
        jokeService: JokeService());
  }

  void _scrollListener() {
    if (_pageController.position.extentAfter < 2000 && canLoadMore) {
      print("Load more stuffs");
      jokeListBloc.getItems();
      canLoadMore = false;
    }
  }

  _handlePageChanged(index, Joke joke) {
    // _currentPageIndex = index;
    jokeListBloc.changeCurrentJoke(joke);
    jokeControlBloc = JokeControlBloc(
        jokeControlled: joke,
        jokeListBloc: jokeListBloc,
        jokeService: JokeService());
  }

  _displayImageJoke(Joke joke) {
    return Stack(
      children: <Widget>[
        ZoomableImage(NetworkImage(joke.imageUrl),
            placeholder: const Center(child: const CircularProgressIndicator()),
            backgroundColor: Colors.black),
        (joke.text != null)
            ? _buildImageJokeTextContent(joke.text)
            : Container(),
      ],
    );
  }

  _displayTextJoke(Joke joke) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: 40.0),
          child: Text(
            joke.text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        )
      ],
    );
  }

  _buildImageJokeTextContent(String content) {
    return Positioned(
      child: (content.length > 50)
          ? ExpansionTile(
              title: Text(content.substring(0, 47) + '...'),
              children: <Widget>[Text(content)],
            )
          : Text(content),
    );
  }

  _jokeSlide(UnmodifiableListView<Joke> jokes) {
    return (jokes != null && jokes.isNotEmpty)
        ? PageView.builder(
            itemCount: jokes.length,
            controller: _pageController,
            onPageChanged: (index) {
              _handlePageChanged(index, jokes[index]);
            },
            itemBuilder: (BuildContext context, int index) {
              Joke joke = jokes[index];
              if (joke.hasImage()) {
                return _displayImageJoke(joke);
              } else {
                return _displayTextJoke(joke);
              }
            },
          )
        : CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Joke>(
          initialData: null,
          stream: jokeListBloc.currentJoke,
          builder: (BuildContext context, AsyncSnapshot<Joke> jokeSnapshot) {
            String title =
                (jokeSnapshot.data != null) ? jokeSnapshot.data.title : 'Joke';
            return Text(title);
          },
        ),
      ),
      body: StreamBuilder<LoadState>(
          initialData: Loading(),
          stream: jokeListBloc.loadState,
          builder: (BuildContext context, AsyncSnapshot<LoadState> snapshot) {
            LoadState loadState = snapshot.data;
            if (loadState is LoadComplete && !(loadState is ErrorLoad)) {
              canLoadMore = true;
            }

            return StreamBuilder<UnmodifiableListView<Joke>>(
              stream: jokeListBloc.items,
              builder: (BuildContext context,
                  AsyncSnapshot<UnmodifiableListView<Joke>> jokesSnapshot) {
                
                    return Stack(
                      children: <Widget>[
                        _jokeSlide(jokesSnapshot.data),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: StreamBuilder<Joke>(
                              stream: jokeListBloc.currentJoke,
                              builder: (BuildContext context,
                                  AsyncSnapshot<Joke> jokeSnapshot) {
                                return (jokesSnapshot.hasData)
                                    ? _jokeOptions(jokeSnapshot.data, context)
                                    : Container();
                              }),
                        ),
                      ],
                    );
                  },
            );
          }),
    );
  }

  _jokeOptions(Joke joke, BuildContext context) {
    Color iconColor =
        (joke.hasImage()) ? Colors.white : Theme.of(context).iconTheme.color;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Text('${joke.commentCount} comments'),
                onTap: () {
                  Router.gotoJokeCommentsPage(context, joke: joke);
                },
              ),
              GestureDetector(
                child: Text('${joke.likeCount} likes'),
                onTap: () {
                  Router.gotoJokeLikersPage(context, joke: joke);
                },
              ),
            ],
          ),
        ),

        BlocProvider<JokeControlBloc>(
            bloc: jokeControlBloc,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            JokeActionButton(
                title: 'Likes',
                icon: Icons.thumb_up,
                iconColor: iconColor,
                selected: joke.liked,
                onTap: () {
                  jokeControlBloc.toggleJokeLike();
                }),
            JokeActionButton(
                title: 'Save',
                icon: Icons.arrow_downward,
                iconColor: iconColor,
                selected: false,
                onTap: () {}),
            JokeActionButton(
                title: 'Favorite',
                icon: Icons.favorite,
                iconColor: iconColor,
                selected: joke.favorited,
                onTap: () {
                  jokeControlBloc.toggleJokeFavorite();
                }),
            JokeActionButton(
                title: 'Share',
                icon: Icons.share,
                iconColor: iconColor,
                selected: false,
                onTap: () {}),
          ],
        ),
        ),
        
      ],
    );
  }
}
