import 'dart:async';

import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/constants/constants.dart';


class ApplicationBloc extends BlocBase{


  final _appTitleController = StreamController<String>();

  //streams
  Stream<String> get appTitle => _appTitleController.stream;

  //sinks
  Function(String)  get changeAppTitle => (title) => _appTitleController.sink.add(title);
  

  ApplicationBloc(){
    _appTitleController.sink.add(kAppName);


  }
  @override
  void dispose() {
    print('dispose application bloc');
    _appTitleController.close();
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