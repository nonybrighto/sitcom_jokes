import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/blocs/user_details_bloc.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/ui/widgets/buttons/general_buttons.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_list.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  UserDetailsPage({Key key, this.user}) : super(key: key);

  @override
  _UserDetailsPageState createState() => new _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with SingleTickerProviderStateMixin {
  UserDetailsBloc userDetailsBloc;
  TabController _tabController;
  JokeListBloc jokeListBloc =
      JokeListBloc(jokeService: JokeService());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    print('user details page disposed');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userDetailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    jokeListBloc.fetchUserJokes(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userDetailsBloc.user,
      builder: (context, userSnapshot) {
        User user = userSnapshot.data;
        return Scaffold(
          body: (userSnapshot.hasData)
              ? DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
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
                                    child: FlutterLogo(),
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _buildProfileIcon(user),
                                            _buildDetailsRow(user),
                                            _buildFollowButton(user),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              labelColor: Colors.black87,
                              unselectedLabelColor: Colors.grey,
                              controller: _tabController,
                              tabs: [
                                Tab(icon: Icon(Icons.info), text: "Images"),
                                Tab(
                                    icon: Icon(Icons.lightbulb_outline),
                                    text: "Texts"),
                              ],
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: SliverToBoxAdapter(
                      child: BlocProvider<JokeListBloc>(
                          bloc: jokeListBloc,
                          child: JokeList(),
                        ),
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }

  _buildProfileIcon(User user) {
    return CircleAvatar(
      radius: 60,
      child: Text('hello'),
    );
  }

  _buildDetailsRow(User user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildUserDetail(
            title: 'Jokes', count: user.jokeCount, onPressed: () {}),
            SizedBox(width: 20,),
        _buildUserDetail(
            title: 'Followers', count: user.jokeCount, onPressed: () {}),
            SizedBox(width: 20,), 
        _buildUserDetail(
            title: 'Following', count: user.jokeCount, onPressed: () {}),
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
            Text(count.toString(), style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),),
            Text(title, style:TextStyle(
              fontSize: 15,
              color: Colors.grey,
            )),
          ],
        ),
      ),
    );
  }

  _buildFollowButton(User user) {
    return RoundedButton(
      child: Text(
        (user.followed) ? 'FOLLOWING' : 'FOLLOW',
        style: TextStyle(fontSize: 14),
      ),
      onPressed: () {},
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
