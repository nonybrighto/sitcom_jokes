import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie/movie.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/ui/widgets/app_drawer.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_list.dart';

class HomePage extends StatefulWidget {
  final Movie selectedMovie;
  HomePage({Key key, this.selectedMovie}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  JokeListBloc imageJokeListBloc =JokeListBloc(JokeType.image, jokeService: JokeService());
  JokeListBloc textJokeListBloc =JokeListBloc(JokeType.text, jokeService: JokeService());
  ApplicationBloc appBloc;
  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

    if(widget.selectedMovie != null){
        imageJokeListBloc.fetchMovieJokes(widget.selectedMovie);
        textJokeListBloc.fetchMovieJokes(widget.selectedMovie);
    }else{
      imageJokeListBloc.fetchAllJokes();
      textJokeListBloc.fetchAllJokes();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appBloc =BlocProvider.of<ApplicationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: AppDrawer(imageJokeListBloc: imageJokeListBloc, textJokeListBloc: textJokeListBloc,),
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: StreamBuilder(
              initialData: '------',
              stream: appBloc.appTitle,
              builder: (context , snapshot){
               
                return Text(snapshot.data);
              },
            ),
          ),
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
          floatingActionButton: _buildAddJokeFloatingActionButton(),
        ),
      );
  }

  _buildAddJokeFloatingActionButton(){

    print(_tabController.index);

    

      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
            JokeType jokeTypeToAdd = (_tabController.index == 0)? JokeType.image : JokeType.text;
            Router.gotoAddJokePage(context, jokeType: jokeTypeToAdd, selectedMovie: widget.selectedMovie); 
        },
      );
  }

  @override
  void dispose() {
    print('homepage disposed');
    super.dispose();
  }
}