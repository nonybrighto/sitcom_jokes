import 'dart:async';
import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:http/http.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class AuthService {

  static const userUrl = kAppApiUrl+'/users/';
  static const authUrl = kAppApiUrl+'/auth/';

  AuthService();

  Future<User> authenticateWithFaceBook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
       try{

          }catch(error){
              throw Exception(error.message);
          }
        break;
      case FacebookLoginStatus.cancelledByUser:
            throw Exception('Login Cancelled!');
        break;
      case FacebookLoginStatus.error:
            throw Exception('Login Failed!');
        break;
    }
  }

  Future<User> authenticateWithGoogle() async {

 try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
       GoogleSignInAuthentication googleAuth =   await googleUser.authentication;
   
    } catch (error) {
        throw Exception(error.message);
    }

}

Future<User> signUpWithEmailAndPassword(username, email, password) async {
  Response response;
  try{
     Dio dio = new Dio(); 
      response = await dio.post(userUrl, data: {'username': username, 'email': email, 'password': password});
      User authenticatedUser = User.fromJson(response.data['user']);
      String userJwtToken = response.data['token'];
      _saveUserDetailsToPreference(authenticatedUser, userJwtToken);
      return authenticatedUser;
  } on DioError catch(error){
    if(error.response != null){
        throw Exception(error.response.data['message']);
    }else{
        throw Exception('Error connecting to server');
    } 
  }
}

Future<User> signInWithEmailAndPassword(loginDetial, password) async {
 
  Response response;
  try{
    Dio dio = new Dio(); 
    response = await dio.post(authUrl+'login', data: {'username': loginDetial, 'password': password});
    User authenticatedUser = User.fromJson(response.data['user']);
    String userJwtToken = response.data['token'];
    _saveUserDetailsToPreference(authenticatedUser, userJwtToken);
    return authenticatedUser;
  }catch(error){
    if(error.response != null){
        throw Exception(error.response.data['message']);
    }else{
        throw Exception('Error connecting to server');
    } 
  }
}

_saveUserDetailsToPreference(User user, String userJwtToken) async{

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(kUserJwtTokenPrefKey, userJwtToken);
      pref.setString(kUserIdPrefKey, user.id);
      pref.setString(kUsernamePrefKey, user.username);
      pref.setString(kUsernamePrefKey, user.email);

}

}
