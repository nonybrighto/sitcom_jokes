import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/widgets/general/scroll_list.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_card.dart';



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

            return JokeCard(index, joke:joke);
      },

    );

      // return ListView.builder(

      //   itemBuilder: (context, index){
      //       return JokeCard(index, joke:  Joke((b) => b
      //   ..id = 'id$num'
      //   ..title = 'user joke $num'
      //   ..content = 'user Joke'
      //   ..commentCount = 21
      //   ..likeCount = 1
      //   ..liked = false
      //   ..favorited = false
      //   ..dateAdded = DateTime(2003)
      //   ..jokeType = JokeType.text
      //   ..movie.id = 'movid $num'
      //   ..movie.title = 'movie name $num'
      //   ..movie.tmdbMovieId = 1
      //   ..movie.description = 'description'
      //   ..owner.update((u) => u
      //     ..id = '1 $num'
      //     ..username = 'John $num'
      //     ..profileIconUrl = 'the_url')),);
      //   },
      // );

  }

 
}

