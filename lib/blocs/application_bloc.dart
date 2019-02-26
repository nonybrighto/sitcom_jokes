import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';


class ApplicationBloc extends BlocBase{

  final _appTitle = StreamController<String>();
  Function(String)  get changeTitle => (title) => _appTitle.sink.add(title);
  Stream<String> get appTitle => _appTitle.stream;

  ApplicationBloc(){
    _appTitle.sink.add('Sitcom');

  }
  @override
  void dispose() {
    _appTitle.close();
  }

}

//class ApplicationBloc extends BlocBase{
//
//  final _appTitle = StreamController<String>();
//  Function(String)  get changeTitle => (title) => _appTitle.sink.add(title);
//  Stream<String> get apptitle => _appTitle.stream;
//
//  ApplicationBloc(){
//   _appTitle.sink.add('title');
//  }
//  @override
//  void dispose() {
//    _appTitle.close();
//  }
//
//}