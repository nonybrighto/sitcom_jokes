import 'dart:async';
//import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//import 'package:http/http.dart';
import 'package:built_collection/built_collection.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/models/user_list_response.dart';
//import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class UserService {

  static const userUrl = kAppApiUrl+'/users';
  static const authUrl = kAppApiUrl+'/auth';

  Map<String , String> headers = {'contentType':'application/json'};

  UserService();

Future<User> getUser(User user) async{


    return User((b) => b
      ..id='id $num'
      ..username='peter $num'
      ..profileIconUrl='url $num'
    );

}


Future<UserListResponse> fetchJokeLikers({Joke jokeLiked}) async{

   var userListGen = List.generate(20, (num) => User((b) => b
      ..id='id liked $num'
      ..username='peter liked $num'
      ..profileIconUrl='url $num'
    )).toList();

     BuiltList<User> userList = BuiltList();
      var userBuilder = userList.toBuilder();
      userBuilder.addAll(userListGen);
      userList =userBuilder.build();
      return UserListResponse((b) => b..totalPages = 2..currentPage = 1 ..perPage = 10 ..results =  userList.toBuilder());
}
}
