import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/user_list_bloc.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/ui/widgets/general/scroll_list.dart';
import 'package:sitcom_joke/ui/widgets/user/user_card.dart';

class UserListPage extends StatefulWidget {
  final bool showFollowDetails;
  UserListPage({Key key, this.showFollowDetails = false}) : super(key: key);

  @override
  _UserListPageState createState() => new _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  UserListBloc _userListBloc;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      _userListBloc = BlocProvider.of<UserListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('Users'),),
      body: ScrollList<User>(
      scrollListType: ScrollListType.list,
      listContentStream: _userListBloc.items,
      loadStateStream: _userListBloc.loadState,
      loadMoreAction: (){
        _userListBloc.getItems();
      },
      listItemWidget: (user, index){
        return UserCard(user: user, showFollowDetails: widget.showFollowDetails,);
      },

    ),
    );
  }
}