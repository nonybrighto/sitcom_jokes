import 'package:flutter/material.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/navigation/router.dart';

class UserProfileIcon extends StatelessWidget {

  final User user;
  final Function() onPressed;
  UserProfileIcon({this.user, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onPressed ?? (){
              Router.gotoUserDetailsPage(context, user);
          },
          child: CircleAvatar(
          child: (user.profileIconUrl == null)? Text(user.username.substring(0,1)) : Text(user.profileIconUrl.substring(0,1)),
         // backgroundImage: (user.profileIconUrl!=null)?NetworkImage(user.profileIconUrl): null,
      ),
    );
  }
}