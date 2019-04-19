import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_comment_list_bloc.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/widgets/general/scroll_list.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_comment_card.dart';

class JokeCommentPage extends StatefulWidget {
  JokeCommentPage({Key key}) : super(key: key);

  @override
  _JokeCommentPageState createState() => new _JokeCommentPageState();
}

class _JokeCommentPageState extends State<JokeCommentPage> {
  JokeCommentListBloc _commentListBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _commentListBloc = BlocProvider.of<JokeCommentListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ScrollList<Comment>(
              scrollListType: ScrollListType.list,
              listContentStream: _commentListBloc.items,
              loadStateStream: _commentListBloc.loadState,
              loadMoreAction: () {
                _commentListBloc.getItems();
              },
              listItemWidget: (comment, index) {
                return JokeCommentCard(comment);
              },
            ),
          ),
         _buildCommentBox(),
        ],
      ),
    );
  }

  _buildCommentBox(){

     return Padding(
       padding: const EdgeInsets.only(left: 5, right: 5),
       child: Row(
              children: <Widget>[
                Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'comment...'
                                  ),

                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){
                    
                  },
                )
              ],
            ),
     );
  }
}
