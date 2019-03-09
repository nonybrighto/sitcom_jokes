import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/load_state.dart';

abstract class ListBloc<T> extends BlocBase{
 
  int currentPage  = 1;
  List<T> itemsCache = [];
  final String emptyMessage;
  final _itemsController =  BehaviorSubject<UnmodifiableListView<T>>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getItemsController = StreamController<Null>();
  final _updateItemController =StreamController<T>();
  
  //streams
  Stream<UnmodifiableListView<T>> get items => _itemsController.stream;
  Stream<LoadState> get loadState => _loadStateController.stream;
 
  //sink
  void Function() get getItems => () => _getItemsController.sink.add(null);
  void Function(T) get updateItem => (item) => _updateItemController.sink.add(item);


  ListBloc({this.emptyMessage}){

    _getItemsController.stream.listen((_){
        _retrieveItemsFromSource();
    });


    _updateItemController.stream.listen((T item){

        _updateItem(item);

    });

  }

  _updateItem(T updatedItem){
        int indexToUpdate = itemsCache.indexWhere((currentItem) => itemUpdateCondition(currentItem, updatedItem));
        itemsCache[indexToUpdate] = updatedItem;
        _itemsController.sink.add(UnmodifiableListView<T>(itemsCache));
  }
  
  _retrieveItemsFromSource() async{

    if(currentPage == 1){
      _loadStateController.sink.add(Loading());
    }else{
      _loadStateController.sink.add(LoadingMore());
    }

    try{
      List<T> gottenItems = await retrieveFromServer();
      if(currentPage == 1){
        if(gottenItems.isEmpty){
          _loadStateController.sink.add(LoadEmpty(emptyMessage));
        }else{
          _changeItems(gottenItems);
          _loadStateController.sink.add(Loaded());
        }

      }else{
        if(gottenItems.isEmpty){
          _loadStateController.sink.add(LoadEnd());
        }else {
          _appendItems(gottenItems);
          _loadStateController.sink.add(Loaded());
        }
      }

      currentPage++;
    }catch(err){
      if (currentPage == 1){
        _loadStateController.sink.add(LoadError('Error during the loading of item'));
      }else{
        _loadStateController.sink.add(LoadMoreError('Error while loading more items'));
      }
    }
  }

  _appendItems(List<T> gottenItems){
          itemsCache.addAll(gottenItems);
          _itemsController.sink.add(UnmodifiableListView<T>(itemsCache));
  }

  _changeItems(List<T> gottenItems){
          itemsCache = gottenItems;
          _itemsController.sink.add(UnmodifiableListView(itemsCache));
  }


  Future<List<T>> retrieveFromServer();

  bool itemUpdateCondition(T currentItem , T updatedItem);

  close(){
   _loadStateController.close();
   _itemsController.close();
   _getItemsController.close();
   _updateItemController.close();
  }

  @override
  void dispose() {
  
  }
}