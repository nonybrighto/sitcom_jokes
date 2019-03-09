import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sitcom_joke/models/load_state.dart';

enum ScrollListType{
  grid,
  list
}

class ScrollList<T> extends StatefulWidget {
  final Stream<LoadState> loadStateStream;
  final Stream<UnmodifiableListView<T>> listContentStream;
  final Function loadMoreAction;
  final Widget Function(T, int) listItemWidget;
  final ScrollListType scrollListType;
  final int gridCrossAxisCount;

  ScrollList({Key key, this.loadStateStream, this.listContentStream, this.loadMoreAction, this.listItemWidget, @required this.scrollListType, this.gridCrossAxisCount}) : super(key: key){

      if(scrollListType == ScrollListType.grid && gridCrossAxisCount == null ||
        gridCrossAxisCount != null && scrollListType != ScrollListType.grid
      ){
          throw 'Grid should have a count or type should be grid';
      }

  }


  @override
  _ScrollListState<T> createState() => new _ScrollListState<T>();

}

class _ScrollListState<T> extends State<ScrollList<T>> {

  ScrollController _scrollController = new ScrollController();
  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2000 && canLoadMore) {
        widget.loadMoreAction();
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
              },
                child: Column(
                children: <Widget>[
                  Text((error as LoadError).message),
                  
                  RaisedButton(child:  Text('RETRY'), onPressed: (){
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
          child: ListTile(title: Text((error as LoadMoreError).message), trailing: RaisedButton(child:  Text('RETRY'), onPressed: (){
                  print('reload more pressed');
                  onRetry();
                })));
    }else{
      return _dumbPlaceHolder();
    }
  }

  _showEmpty(LoadState loadState, {bool visible}){
     
     if(visible){
        return Center(
          child: Text((loadState as LoadEmpty).message),
        );
     }else{
        return _dumbPlaceHolder();
     }
     
  }

  _contentList({bool visible}){

    if(visible){
      return StreamBuilder<UnmodifiableListView<T>>(
            initialData: UnmodifiableListView([]),
            stream: widget.listContentStream,
            builder: (BuildContext context, AsyncSnapshot<UnmodifiableListView<T>> listItemSnapshot){
              UnmodifiableListView<T> listItems = listItemSnapshot.data;
               return ListView.builder(
                    controller: _scrollController,
                    itemCount: listItems.length,
                    itemBuilder: (BuildContext context, int index){
                      return widget.listItemWidget(listItems[index], index);
                     // return widget.listItemWidget(widget.item, index);
                      //return Text('ssss');
                    },
                );
            },
      );
    }else{
      return _dumbPlaceHolder();
    }
    
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<LoadState>(
      stream: widget.loadStateStream,
      builder: (BuildContext context,AsyncSnapshot<LoadState> snapshot){
        LoadState loadState =snapshot.data;

        if(loadState is LoadComplete && !(loadState is ErrorLoad)){
          canLoadMore = true;
        }

        return Stack(
          children: <Widget>[
              _initialProgress(visible: loadState is Loading),
              _initialError(loadState , visible: loadState is LoadError, onRetry: (){ 
                widget.loadMoreAction();
                }),
              _moreError(loadState, visible: loadState is LoadMoreError,  onRetry: (){ 
                  widget.loadMoreAction(); 
                }),
              _showEmpty(loadState, visible: loadState is LoadEmpty),
              _contentList(visible: !(loadState is Loading) && !(loadState is LoadEmpty) && !(loadState is LoadError)),
          ],
        );
      },
      
    );
  }
}