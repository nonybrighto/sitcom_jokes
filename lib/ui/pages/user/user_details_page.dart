import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/blocs/user_details_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_list.dart';

class UserDetailsPage extends StatefulWidget {
  UserDetailsPage({Key key}) : super(key: key);

  @override
  _UserDetailsPageState createState() => new _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with SingleTickerProviderStateMixin {
  UserDetailsBloc userDetailsBloc;
  TabController _tabController;
  JokeListBloc imageJokeListBloc =JokeListBloc(JokeType.image, jokeService: JokeService());
  JokeListBloc textJokeListBloc =JokeListBloc(JokeType.text, jokeService: JokeService());


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
  }

  @override
  Widget build(BuildContext context) {
   

    return StreamBuilder(
      stream: userDetailsBloc.user,
      builder: (context, userSnapshot) {
        User user = userSnapshot.data;
        return Scaffold(
          body: (userSnapshot.hasData)? DefaultTabController(
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
                        title: Text(user.name),
                        background: Stack(
                          children: <Widget>[
                                   Container(
                                      color: Colors.pink,
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          children: <Widget>[
                                            CircleAvatar(child: Text('H'), radius: 60,),
                                            Text('Username'),
                                          ],
                                        ),
                                      ),
                                    )
                          ],
                        ),)
                  ),
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
              body: TabBarView(
                controller: _tabController,
                children: [
                   BlocProvider<JokeListBloc>(
                    bloc: imageJokeListBloc,
                    child: JokeList(JokeType.image),
              ),
                BlocProvider<JokeListBloc>(
                    bloc: textJokeListBloc,
                    child: JokeList(JokeType.text),
              ),
                ],
              ),
            ),
          ):Container(),
        );
      },
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
