import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/user_control_bloc.dart';
import 'package:sitcom_joke/blocs/user_list_bloc.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/user_service.dart';
import 'package:sitcom_joke/ui/widgets/user/user_profile_icon.dart';
import 'package:sitcom_joke/ui/widgets/user/username_text.dart';

class UserCard extends StatelessWidget {
  final User user;
  final bool showFollowDetails;
  UserCard({this.user, this.showFollowDetails});

  @override
  Widget build(BuildContext context) {
    String jokeCountWord = (user.jokeCount > 0) ? ' Jokes' : ' Joke';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
            leading: UserProfileIcon(
              user: user,
            ),
            title: UsernameText(user: user),
            subtitle: Row(
              children: <Widget>[
                Text(user.jokeCount.toString() + jokeCountWord),
                SizedBox(
                  width: 10,
                ),
                (user.following && showFollowDetails)
                    ? Chip(
                        label: Text(
                          'FOLLOWS YOU',
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    : Container()
              ],
            ),
            trailing: (showFollowDetails)
                ? _buildFollowButton(context)
                : Container(
                    width: 0,
                  )),
        Divider(
          indent: 59,
        )
      ],
    );
  }

  _buildFollowButton(BuildContext context) {
    UserControlBloc userControlBloc = UserControlBloc(
        userControlled: user,
        userListBloc: BlocProvider.of<UserListBloc>(context),
        userService: UserService());
    return BlocProvider<UserControlBloc>(
        bloc: userControlBloc,
        child: (user.followed)
            ? FlatButton(
                child: Text(
                  'FOLLOWING',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  userControlBloc.toggleUserFollow();
                },
              )
            : RaisedButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  'FOLLOW',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                onPressed: () {
                  userControlBloc.toggleUserFollow();
                },
              ));
  }
}
