import 'dart:async';

import 'package:sitcom_joke/blocs/list_bloc.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/user_service.dart';

class UserListBloc extends ListBloc<User>{
 
 final UserService userService;

  Joke _jokeLiked;

  UserListFetchType userListFetchType;


  StreamController _fetchjokeLikersController =StreamController<Joke>();


  //stream


  //sink
  void Function(Joke) get fetchJokeLikers => (joke) => _fetchjokeLikersController.sink.add(joke);

 
 UserListBloc({this.userService}){


    _fetchjokeLikersController.stream.listen((joke){
          userListFetchType =UserListFetchType.jokeLikers;
          _getFirstPageUsers();
    });
 }
 
  @override
  void dispose() {

    _fetchjokeLikersController.close();

  }

  _getFirstPageUsers(){
     currentPage = 1;
     getItems();
  }

  @override
  Future<List<User>> fetchFromServer() async{

    switch (userListFetchType) {
      case UserListFetchType.jokeLikers:
        return await userService.fetchJokeLikers(jokeLiked: _jokeLiked);
        break;
      default:
          return null;
    }
  }

  @override
  bool itemUpdateCondition(User currentUser, User updatedUser) {
    return currentUser.id == updatedUser.id;
  }
}

enum UserListFetchType{jokeLikers }