import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/blocs/user_control_bloc.dart';
import 'package:sitcom_joke/blocs/user_details_bloc.dart';
import 'package:sitcom_joke/blocs/user_list_bloc.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/services/user_service.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';
import 'package:sitcom_joke/ui/widgets/buttons/general_buttons.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_list.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  final UserListBloc userListBloc;
  UserDetailsPage({Key key, this.user, this.userListBloc}) : super(key: key);

  @override
  _UserDetailsPageState createState() => new _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with SingleTickerProviderStateMixin {
  UserDetailsBloc userDetailsBloc;
  JokeListBloc jokeListBloc;
  UserControlBloc userControlBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    print('user details page disposed');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    jokeListBloc = JokeListBloc(jokeService: JokeService(), fetchType: JokeListFetchType.userJokes, user: widget.user );
    userDetailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    userControlBloc = UserControlBloc(
        userControlled: widget.user,
        userDetailsBloc: userDetailsBloc,
        userListBloc: widget.userListBloc,
        userService: UserService());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userDetailsBloc.user,
      builder: (context, userSnapshot) {
        User user = userSnapshot.data;
        return Scaffold(
          body: (userSnapshot.hasData)
              ? CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                        expandedHeight: 250.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(user.username),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Container(
                                color: Colors.pink,
                                child: (user.photoUrl != null)? Image.network(user.photoUrl, fit: BoxFit.cover,):null,
                              ),
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: _buildProfileHeader(user),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SliverToBoxAdapter(
                      child: BlocProvider<JokeListBloc>(
                        bloc: jokeListBloc,
                        child: JokeList(),
                      ),
                    )
                  ],
                )
              : Container(),
        );
      },
    );
  }


  _buildProfileHeader(User user){

    return Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _buildProfileIcon(user),
                                        _buildDetailsRow(user),
                                        StreamBuilder<User>(
                                            stream: BlocProvider.of<
                                                    AuthBloc>(context)
                                                .currentUser,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<User>
                                                    currentUserSnapshot) {
                                              User currentUser =
                                                  currentUserSnapshot.data;
                                              if (currentUser != null &&
                                                  currentUser.id == user.id) {
                                                return Container();
                                              }
                                              return _buildFollowButton(user);
                                            })
                                      ],
                                    ),
                                  );
  }

  _buildProfileIcon(User user) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: (user.photoUrl != null)?NetworkImage(user.photoUrl): null,
      child:  (user.photoUrl == null)?Text(user.username.substring(0,1), style: TextStyle(fontSize: 33),): null,
    );
  }

  _buildDetailsRow(User user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildUserDetail(
            title: 'Jokes', count: user.jokeCount, onPressed: () {}),
        SizedBox(
          width: 20,
        ),
        _buildUserDetail(
            title: 'Followers',
            count: user.followerCount,
            onPressed: () {
              Router.gotoUserFollowPage(context,
                  user: user, followType: UserFollowType.followers);
            }),
        SizedBox(
          width: 20,
        ),
        _buildUserDetail(
            title: 'Following',
            count: user.followingCount,
            onPressed: () {
              Router.gotoUserFollowPage(context,
                  user: user, followType: UserFollowType.following);
            }),
      ],
    );
  }

  _buildUserDetail({String title, int count, Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              count.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  _buildFollowButton(User user) {
    return BlocProvider(
      bloc: userControlBloc,
      child: StreamBuilder<LoadState>(
          initialData: Loading(),
          stream: userDetailsBloc.loadState,
          builder:
              (BuildContext context, AsyncSnapshot<LoadState> loadSnapshot) {
            return StreamBuilder<bool>(
                initialData: false,
                stream:
                    BlocProvider.of<AuthBloc>(context).isAuthenticated,
                builder: (BuildContext context,
                    AsyncSnapshot<bool> isAuthenticatedSnapshot) {
                  return RoundedButton(
                    child: (loadSnapshot.data is Loading)
                        ? CircularProgressIndicator()
                        : Text(
                            (user.followed) ? 'FOLLOWING' : 'FOLLOW',
                            style: TextStyle(fontSize: 14),
                          ),
                    onPressed: (loadSnapshot.data is Loaded)
                        ? () {
                            if (isAuthenticatedSnapshot.data) {
                              userControlBloc.toggleUserFollow();
                            } else {
                              Router.gotoAuthPage(context, AuthType.login);
                            }
                          }
                        : null,
                  );
                });
          }),
    );
  }
}
