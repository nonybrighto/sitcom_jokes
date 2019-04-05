import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitcom_joke/models/user.dart';

import '../constants/constants.dart';


class AuthService {
  static const userUrl = kAppApiUrl + '/users/';
  static const authUrl = kAppApiUrl + '/auth/';

  AuthService();

  Future<User> authenticateWithFaceBook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        print(result.accessToken.token);
        return _authenticateFacebookUserOnServer(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw Exception('Facebook Login Cancelled!');
        break;
      case FacebookLoginStatus.error:
        throw Exception('Facebook Login Failed!');
        break;
      default:
        throw Exception('Facebook Login Failed!');
    }
  }

  Future<User> authenticateWithGoogle() async {
    GoogleSignInAuthentication googleAuth;
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser.authentication;
    } catch (error) {
      throw Exception('Failed to connect to Google!');
    }
    return _authenticateGoogleUserOnServer(googleAuth.idToken);
  }

  Future<User> signUpWithEmailAndPassword(username, email, password) async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post(userUrl,
          data: {'username': username, 'email': email, 'password': password});
      User authenticatedUser = User.fromJson(response.data['user']);
      String userJwtToken = response.data['token'];
      _saveUserDetailsToPreference(authenticatedUser, userJwtToken);
      return authenticatedUser;
    } on DioError catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }

  Future<User> signInWithEmailAndPassword(loginDetial, password) async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post(authUrl + 'login',
          data: {'username': loginDetial, 'password': password});
      User authenticatedUser = User.fromJson(response.data['user']);
      String userJwtToken = response.data['token'];
      _saveUserDetailsToPreference(authenticatedUser, userJwtToken);
      return authenticatedUser;
    } catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }

  Future<User> _authenticateFacebookUserOnServer(String accessToken) async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post(authUrl + 'facebook/token',
          data: {'access_token': accessToken});
      User authenticatedUser = User.fromJson(response.data['user']);
      String userJwtToken = response.data['token'];
      _saveUserDetailsToPreference(authenticatedUser, userJwtToken);
      return authenticatedUser;
    } catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server!');
      }
    }
  }

  Future<User> _authenticateGoogleUserOnServer(String idToken) async {
    Response response;
    try {
      Dio dio = new Dio();
      response =
          await dio.post(authUrl + 'google/token', data: {'id_token': idToken});
      User authenticatedUser = User.fromJson(response.data['user']);
      String userJwtToken = response.data['token'];
      _saveUserDetailsToPreference(authenticatedUser, userJwtToken);
      return authenticatedUser;
    } catch (error) {
      if (error.response != null) {
        throw Exception(error.response.data['message']);
      } else {
        throw Exception('Error connecting to server');
      }
    }
  }

  _saveUserDetailsToPreference(User user, String userJwtToken) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(kUserJwtTokenPrefKey, userJwtToken);
    pref.setString(kUserIdPrefKey, user.id);
    pref.setString(kUsernamePrefKey, user.username);
    pref.setString(kUsernamePrefKey, user.email);
  }
}
