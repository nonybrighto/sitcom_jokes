import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/models/user_list_response.dart';
import 'package:sitcom_joke/services/auth_header.dart';
import '../constants/constants.dart';

class UserService {

  final String authUrl = kAppApiUrl+'/auth';
  final String userUrl = kAppApiUrl + '/user/';
  final String usersUrl = kAppApiUrl + '/users/';
  final String jokesUrl = kAppApiUrl + '/jokes/';

  Dio dio = new Dio();

  Map<String , String> headers = {'contentType':'application/json'};

  UserService();

Future<User> getUser(User user) async{


    try {
       Options authHeaderOption = await getAuthHeaderOption();
       Response response = await dio.get(usersUrl + '${user.id}', options: authHeaderOption);
      return User.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
}


Future<UserListResponse> fetchJokeLikers({Joke jokeLiked, int page}) async{

     try {
       Options authHeaderOption = await getAuthHeaderOption();
       Response response = await dio.get(jokesUrl + '${jokeLiked.id}/likes?page=$page', options: authHeaderOption);
      return UserListResponse.fromJson(response.data);
    } on DioError catch (error) {
      throw Exception((error.response != null)
          ? error.response.data['message']
          : 'Error Connectiing to server');
    }
   
}
}
