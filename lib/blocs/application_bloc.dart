import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/user.dart';


class ApplicationBloc extends BlocBase{


  final _appTitleController = StreamController<String>();
  final _currentUserController = BehaviorSubject<User>();
  final _isAuthenticatedController =BehaviorSubject<bool>();

  //streams
  Stream<String> get appTitle => _appTitleController.stream;
  Stream<User> get currentUser => _currentUserController.stream;
  Stream<bool> get isAuthenticated => _isAuthenticatedController.stream;


  //sinks
  Function(String)  get changeAppTitle => (title) => _appTitleController.sink.add(title);
  Function(User)  get changeCurrentUser => (user) => _currentUserController.sink.add(user);

  ApplicationBloc(){
    _appTitleController.sink.add(kAppName);
    _isAuthenticatedController.sink.add(false);
    _currentUserController.stream.listen((user){
        _isAuthenticatedController.sink.add(user != null);
    });


  }
  @override
  void dispose() {
    print('dispose application bloc');
    _appTitleController.close();
    _currentUserController.close();
    _isAuthenticatedController.close();
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