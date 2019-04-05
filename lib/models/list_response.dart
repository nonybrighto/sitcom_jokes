import 'package:built_collection/built_collection.dart';

abstract class ListResponse<T>{


  int get totalPages;
  int get perPage;
  int get currentPage;
  BuiltList<T> get results; 

}