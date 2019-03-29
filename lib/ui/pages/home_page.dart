import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/services/joke_service.dart';
import 'package:sitcom_joke/ui/widgets/app_drawer.dart';
import 'package:sitcom_joke/ui/widgets/joke/joke_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>{

  JokeListBloc imageJokeListBloc =JokeListBloc(JokeType.image, jokeService: JokeService());
  JokeListBloc textJokeListBloc =JokeListBloc(JokeType.text, jokeService: JokeService());
  ApplicationBloc appBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appBloc =BlocProvider.of<ApplicationBloc>(context);
    imageJokeListBloc.fetchAllJokes();
    textJokeListBloc.fetchAllJokes();
  }

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: AppDrawer(imageJokeListBloc: imageJokeListBloc, textJokeListBloc: textJokeListBloc,),
          appBar: AppBar(
            bottom: TabBar(
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
      );
  }

  @override
  void dispose() {
    print('homepage disposed');
    super.dispose();
  }
}