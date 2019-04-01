import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/widgets/general/scroll_list.dart';



class JokeList extends StatefulWidget {
  final JokeType jokeType;
  JokeList(this.jokeType, {Key key}) : super(key: key);

  @override
  _JokeListState createState() => new _JokeListState();
}

class _JokeListState extends State<JokeList> {

 JokeListBloc jokeListBloc;

 
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     jokeListBloc = BlocProvider.of<JokeListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return  ScrollList<Joke>(
      scrollListType: ScrollListType.list,
      listContentStream: jokeListBloc.items,
      loadStateStream: jokeListBloc.loadState,
      loadMoreAction: (){
        jokeListBloc.getItems();
      },
      listItemWidget: (joke, int index){
        return ListTile(title: Container(height: 30.0, child: Text(joke.title)), trailing: Icon(Icons.thumb_up, color: (joke.isLiked? Colors.amber: Colors.black),), onTap: (){
            jokeListBloc.changeCurrentJoke(joke);
            Router.gotoJokeDisplayPage(context, initialPage: index, jokeType: widget.jokeType, jokeListBloc: jokeListBloc, joke: joke);
        },);
      },

    );
  }
}

