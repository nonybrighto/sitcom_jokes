import 'package:flutter/material.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/navigation/router.dart';

class UsernameText extends StatelessWidget {

  final User user;
  final Function() onPressed;
  final TextStyle style;
  UsernameText({this.user, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onPressed ?? (){
              Router.gotoUserDetailsPage(context, user);
          },
          child: Text(user.username, style: style ?? TextStyle(
             fontSize: 15,
             fontWeight: FontWeight.bold
          ),),
    );
  }
}