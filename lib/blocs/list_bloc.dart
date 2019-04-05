import 'dart:async';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/list_response.dart';
import 'package:sitcom_joke/models/load_state.dart';

abstract class ListBloc<T> extends BlocBase {
  int currentPage = 1;
  List<T> itemsCache = [];
  final _itemsController = BehaviorSubject<UnmodifiableListView<T>>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getItemsController = StreamController<Null>();
  final _updateItemController = StreamController<T>();

  //streams
  Stream<UnmodifiableListView<T>> get items => _itemsController.stream;
  Stream<LoadState> get loadState => _loadStateController.stream;

  //sink
  void Function() get getItems => () => _getItemsController.sink.add(null);
  void Function(T) get updateItem =>
      (item) => _updateItemController.sink.add(item);

  ListBloc() {
    _getItemsController.stream.listen((_) {
      _fetchItemsFromSource();
    });

    _updateItemController.stream.listen((T item) {
      _updateItem(item);
    });
  }

  _updateItem(T updatedItem) {
    int indexToUpdate = itemsCache.indexWhere(
        (currentItem) => itemUpdateCondition(currentItem, updatedItem));
    itemsCache[indexToUpdate] = updatedItem;
    _itemsController.sink.add(UnmodifiableListView<T>(itemsCache));
  }

  _fetchItemsFromSource() async {
    _loadStateController.sink
        .add((currentPage == 1) ? Loading() : LoadingMore());

    try {
      ListResponse gottenResponse = await fetchFromServer();
      List<T> gottenItems = gottenResponse.results.toList();

      if (currentPage == 1) {
        if (gottenItems.isEmpty) {
          _loadStateController.sink.add(LoadEmpty(getEmptyResultMessage()));
        } else {
          _changeItems(gottenItems);
          _loadStateController.sink.add((_isPageEnd(gottenResponse))?LoadEnd():Loaded());
        }
      } else {
          _appendItems(gottenItems);
          _loadStateController.sink.add((_isPageEnd(gottenResponse))?LoadEnd():Loaded());
      }

      currentPage++;
    } catch (err) {
      if (currentPage == 1) {
        _loadStateController.sink
            .add(LoadError('Error during the loading of item'));
      } else {
        _loadStateController.sink
            .add(LoadMoreError('Error while loading more items'));
      }
    }
  }

  _appendItems(List<T> gottenItems) {
    itemsCache.addAll(gottenItems);
    _itemsController.sink.add(UnmodifiableListView<T>(itemsCache));
  }

  _changeItems(List<T> gottenItems) {
    itemsCache = gottenItems;
    _itemsController.sink.add(UnmodifiableListView(itemsCache));
  }

  _isPageEnd(ListResponse listResponse) {
    return listResponse.currentPage == listResponse.totalPages;
  }

  Future<ListResponse> fetchFromServer();

  bool itemUpdateCondition(T currentItem, T updatedItem);
  String getEmptyResultMessage();

  close() {
    _loadStateController.close();
    _itemsController.close();
    _getItemsController.close();
    _updateItemController.close();
  }

  @override
  void dispose() {}
}
