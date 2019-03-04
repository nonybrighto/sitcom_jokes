import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:zoomable_image/zoomable_image.dart';

class JokeDisplayPage extends StatefulWidget {
  final int initialPage;
  final JokeType jokeType;
  JokeDisplayPage({Key key, this.initialPage, this.jokeType})
      : super(key: key);

  @override
  _JokeDisplayPageState createState() => new _JokeDisplayPageState();
}

class _JokeDisplayPageState extends State<JokeDisplayPage> {
  JokeListBloc jokeListBloc;
  PageController _pageController;

  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _pageController.addListener(_scrollListener);
  }


  void _scrollListener() {
    print(_pageController.position.extentAfter);
    if (_pageController.position.extentAfter < 2000 && canLoadMore) {
      print("Load more stuffs");
      jokeListBloc.getItems();
      canLoadMore = false;
    }
  }

  _handlePageChanged(index, Joke joke) {
    // _currentPageIndex = index;
    jokeListBloc.changeCurrentJoke(joke);
  }

  _displayImageJoke(Joke joke) {
    return ZoomableImage(NetworkImage(joke.content),
        placeholder: const Center(child: const CircularProgressIndicator()),
        backgroundColor: Colors.black);
  }

  _displayTextJoke(Joke joke) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: 40.0),
          child: Text(
            joke.content,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        )
      ],
    );
  }

  _jokeSlide(UnmodifiableListView<Joke> jokes) {
    return (jokes.isNotEmpty)
        ? PageView.builder(
            itemCount: jokes.length,
            controller: _pageController,
            onPageChanged: (index) {
              _handlePageChanged(index, jokes[index]);
            },
            itemBuilder: (BuildContext context, int index) {
              Joke joke = jokes[index];
              if (widget.jokeType == JokeType.image) {
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
    jokeListBloc = BlocProvider.of<JokeListBloc>(context);
    
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
      backgroundColor:
          (widget.jokeType == JokeType.image) ? Colors.black : null,
      body: StreamBuilder<LoadState>(
          initialData: Loading(),
          stream: jokeListBloc.loadState,
          builder: (BuildContext context, AsyncSnapshot<LoadState> snapshot) {
            LoadState loadState = snapshot.data;
            if (loadState is LoadComplete && !(loadState is ErrorLoad)) {
              canLoadMore = true;
            }

            return StreamBuilder<UnmodifiableListView<Joke>>(
              initialData: UnmodifiableListView([]),
              stream: jokeListBloc.items,
              builder: (BuildContext context,
                  AsyncSnapshot<UnmodifiableListView<Joke>> jokesSnapshot) {
                UnmodifiableListView<Joke> jokes = jokesSnapshot.data;

                return Stack(
                  children: <Widget>[
                    _jokeSlide(jokes),
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
                          },
                        )),
                  ],
                );
              },
            );
          }),
    );
  }

  _jokeOptions(Joke joke, BuildContext context) {

    return Column(

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(child: Text('${joke.totalComments} comments'), onTap: (){
                Router.gotoJokeCommentsPage(context, joke: joke);
              },),
              Text('2000 likes')
          ],),
        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _jokeActionBox('Likes', Icons.thumb_up, false, () {}),
          _jokeActionBox('Save', Icons.arrow_downward, false, () {}),
          _jokeActionBox('Favorite', Icons.favorite,
              (joke != null) ? /*joke.isFaved*/ true : false, () {}),
          _jokeActionBox('Share', Icons.share, false, () {}),
        ],
         )

      ],
    );
  }

  _jokeActionBox(String title, IconData icon, bool selected, onTap) {
    Color iconColor =
        (widget.jokeType == JokeType.image) ? Colors.white : Colors.black;
    Color textColor =
        (widget.jokeType == JokeType.image) ? Colors.grey : Colors.grey;

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(60.0)),
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: (selected) ? Colors.orange : iconColor,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
