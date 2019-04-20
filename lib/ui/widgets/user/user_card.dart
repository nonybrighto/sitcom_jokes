import 'package:flutter/material.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/ui/widgets/user/user_profile_icon.dart';
import 'package:sitcom_joke/ui/widgets/user/username_text.dart';

class UserCard extends StatelessWidget {
  final User user;
  final bool showFollowDetails;
  UserCard({this.user, this.showFollowDetails });

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
          title: UsernameText(user:user),
          subtitle: Row(
            children: <Widget>[
              Text(user.jokeCount.toString() + jokeCountWord),
              SizedBox(
                width: 10,
              ),
              (user.following && showFollowDetails)
                  ? Chip(
                      label: Text('FOLLOWS YOU', style: TextStyle(fontSize: 10),),
                    )
                  : Container()
            ],
          ),
          trailing: (showFollowDetails)?_buildFollowButton():Container(width: 0,)
        ),
        Divider(indent: 59,)
      ],
    );
  }

  _buildFollowButton(){

    return (user.followed)
              ? FlatButton(
                  child: Text('FOLLOWING', style: TextStyle(fontSize: 12),),
                  onPressed: () {},
                )
              : RaisedButton(
                padding: EdgeInsets.all(0),
                  child: Text(
                    'FOLLOW',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  onPressed: () {},
                );
  }
}
