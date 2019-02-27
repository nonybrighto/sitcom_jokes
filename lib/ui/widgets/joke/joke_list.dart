import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/widgets/joke/scroll_list.dart';



class JokeList extends StatefulWidget {
  final JokeType jokeType;
  JokeList(this.jokeType, {Key key}) : super(key: key);

  @override
  _JokeListState createState() => new _JokeListState();
}

class _JokeListState extends State<JokeList> {

 JokeListBloc jokeListBloc;

  @override
  Widget build(BuildContext context) {
    jokeListBloc = BlocProvider.of<JokeListBloc>(context);

    return  ScrollList(
      scrollListType: ScrollListType.list,
      listContentStream: jokeListBloc.jokes,
      loadStateStream: jokeListBloc.loadState,
      loadMoreAction: (){
        jokeListBloc.getJokes();
      },
      listItemWidget: (joke, index){
        return ListTile(title: Container(height: 30.0, child: Text(joke.title)), trailing: Text('dd'), onTap: (){

            jokeListBloc.changeCurrentJoke(joke);
            Router.gotoJokeDisplayPage(context, initialPage: index, jokeType: widget.jokeType, jokeListBloc: jokeListBloc);
        },);
      },

    );
  }
}

