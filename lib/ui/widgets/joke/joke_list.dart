import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/load_state.dart';

class JokeList extends StatefulWidget {
  final JokeType jokeType;
  JokeList(this.jokeType, {Key key}) : super(key: key);

  @override
  _JokeListState createState() => new _JokeListState();
}

class _JokeListState extends State<JokeList> {

  JokeListBloc jokeListBloc;
  ScrollController _scrollController = new ScrollController();
  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 2000 && canLoadMore) {
        // this.widget.movieBloc.nextPage.add(this.widget.tabKey);
        print("Load more stuffs");
        jokeListBloc.getJokes();
      canLoadMore = false;
    }
  }


  _initialProgress({bool visible}){

      if(visible){
        return Center(
          child: CircularProgressIndicator(),
        );
      }else{
        return _dumbPlaceHolder();
      }
  }

  _dumbPlaceHolder(){
        return Container(
          width: 0,
          color: Colors.red,
        );
  }

  _initialError(LoadState error, {bool visible, Function onRetry}){

    if(visible){
        return Center(
            child: InkWell(
              onTap: (){
                    print('The inkwell tapped');
              },
                          child: Column(
                children: <Widget>[
                  Text((error as LoadError).message),
                  
                  RaisedButton(child:  Text('RETRY'), onPressed: (){
                    print('reload pressed');
                    onRetry();
                  },)
                ],
              ),
            ),
        );
    }else{
       return _dumbPlaceHolder();
    }
  }
  _moreError(LoadState error, {bool visible, Function onRetry}){

    if(visible){
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ListTile(title: Text((error as LoadError).message), trailing: RaisedButton(child:  Text('RETRY'), onPressed: (){
                  print('reload more pressed');
                  onRetry();
                })));
    }else{
      return _dumbPlaceHolder();
    }
  }

  _showEmpty(){
      return Center(
        child: Text('No content to load'),
      );
  }

  _contentList(LoadState loadState, {bool visible}){

    return StreamBuilder<UnmodifiableListView<Joke>>(
            initialData: UnmodifiableListView([]),
            stream: jokeListBloc.jokes,
            builder: (BuildContext context, AsyncSnapshot<UnmodifiableListView<Joke>> jokesSnapshot){
              print(jokesSnapshot.error);
                UnmodifiableListView<Joke> jokes = jokesSnapshot.data;
                return (loadState is LoadEnd && jokes.isEmpty)? 
                    _showEmpty()
                :  ListView.builder(
                    controller: _scrollController,
                    itemCount: jokes.length,
                    itemBuilder: (BuildContext context, int index){
                        return ListTile(title: Container(height: 30.0, child: Text(jokes[index].title)), trailing: Text('dd'),);
                    },
                );
            },

    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    jokeListBloc = BlocProvider.of<JokeListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    print('Build Called ---------------');



    return StreamBuilder<LoadState>(
      stream: jokeListBloc.loadState,
      builder: (BuildContext context,AsyncSnapshot<LoadState> snapshot){
        LoadState loadState =snapshot.data;

        if(loadState is LoadComplete && !(loadState is ErrorLoad)){
          canLoadMore = true;
        }

        return Stack(
         
          children: <Widget>[

              _contentList(loadState , visible: true),
              //(loadState is Loaded)? Text('loadsate loaded'): Container(),
              _initialProgress(visible: loadState is Loading),
              _initialError(loadState , visible: loadState is LoadError, onRetry: (){ 
                jokeListBloc.getJokes(); 
                }),
              _moreError(loadState, visible: loadState is LoadMoreError,  onRetry: (){ 
                jokeListBloc.getJokes(); 
                }),
          ],
        );
      },
      
    );
    // return Column(
    //   children: <Widget>[
    //           StreamBuilder(
    //           initialData: '------',
    //           stream: appBloc.apptitle,
    //           builder: (context , snapshot){
    //             return Text(snapshot.data);
    //           },
    //         ),
    //           StreamBuilder(
    //           initialData: '------',
    //           stream: jokeListBloc.jokeTitle,
    //           builder: (context , snapshot){
    //             return Text(snapshot.data);
    //           },
    //         ),

            

            
    //   ],
    // );
  }
}