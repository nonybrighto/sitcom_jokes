import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/user_list_bloc.dart';
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
              Router.gotoUserDetailsPage(context, user, userListBloc: BlocProvider.of<UserListBloc>(context));
          },
          child: CircleAvatar(
          child: (user.photoUrl == null)? Text(user.username.substring(0,1)) : null,
          backgroundImage: (user.photoUrl!=null)?NetworkImage(user.photoUrl): null,
      ),
    );
  }
}