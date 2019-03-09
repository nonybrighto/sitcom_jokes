import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_comment_list_bloc.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/widgets/general/scroll_list.dart';

class JokeCommentPage extends StatefulWidget {
  JokeCommentPage({Key key}) : super(key: key);

  @override
  _JokeCommentPageState createState() => new _JokeCommentPageState();
}

class _JokeCommentPageState extends State<JokeCommentPage> {

  JokeCommentListBloc _commentListBloc;

  @override
  Widget build(BuildContext context) {

    _commentListBloc = BlocProvider.of<JokeCommentListBloc>(context);

    return Scaffold(

      appBar: AppBar(title: Text('Joke title'),),
      body: ScrollList<Comment>(
      scrollListType: ScrollListType.list,
      listContentStream: _commentListBloc.items,
      loadStateStream: _commentListBloc.loadState,
      loadMoreAction: (){
        _commentListBloc.getItems();
      },
      listItemWidget: (comment, index){
        return ListTile(
          leading: GestureDetector(
            onTap: (){
              Router.gotoUserDetailsPage(context, comment.owner);
            },
            child: CircleAvatar(child: Text(comment.owner.name.substring(0, 1)), )),
          title: Container(height: 30.0, child: Text(comment.content)), trailing: Text('dd'),);
      },

    ),
    );
  }
}