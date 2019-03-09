import 'dart:async';
//import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//import 'package:http/http.dart';
import 'package:sitcom_joke/models/user.dart';
//import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class UserService {

  static const userUrl = kAppApihost+'/users';
  static const authUrl = kAppApihost+'/auth';

  Map<String , String> headers = {'contentType':'application/json'};

  UserService();

  Future<User> authenticateWithFaceBook() async {
    // var facebookLogin = new FacebookLogin();
    // var result = await facebookLogin.logInWithReadPermissions(['email']);
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //             try{
    //           final response = await http.post(authUrl+'/facebook/token', headers: headers, body: {"access_token": result.accessToken.token});  
              
    //           final responseJson = json.decode(response.body);
    //           if (response.statusCode < 200 || response.statusCode >= 400) {
    //               throw new Exception(responseJson['message']);
    //           }
    //           return User.fromMap(responseJson['user']);
    //       }catch(err){
    //           throw Exception(err.message);
    //       }
    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     throw(AppError('Login Cancelled')); 
    //     break;
    //   case FacebookLoginStatus.error:
    //     throw(AppError('Login Failed'));
    //     break;
    // }
    return User((b) => b
      ..id='id'
      ..name='peter'
      ..profileIconUrl='url'
    );
  }

  Future<User> authenticateWithGoogle() async {

//    GoogleSignIn _googleSignIn = GoogleSignIn();
 
//  GoogleSignInAuthentication googleAuth;
  
// try{
//   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//   googleAuth = await googleUser.authentication;
// }catch(err){
//   throw(AppError('Error occured during google authentication')); 
// }

// print(googleAuth.idToken);
// print(googleAuth.accessToken);

//   try{
//     final response = await http.post(authUrl+'/google/token', headers: headers, body: {"access_token": googleAuth.accessToken, 'id_token': googleAuth.idToken}); 
//     final responseJson = json.decode(response.body);
//     if (response.statusCode < 200 || response.statusCode >= 400) {
//         throw new Exception(responseJson['message']);
//     }
//     return User.fromMap(responseJson['user']);
//  }catch(err){
//     throw Exception(err.message);
//  }

return User((b) => b
      ..id='id'
      ..name='peter'
      ..profileIconUrl='url'
    );

}

Future<User> signUpWithEmailAndPassword(username, email, password) async {
  
//  try{
//     final response = await http.post(userUrl, headers: headers, body: {"username": username, "email": email, "password": password});  
    
//     final responseJson = json.decode(response.body);
//     if (response.statusCode < 200 || response.statusCode >= 400) {
//         throw new Exception(responseJson['message']);
//       }
//     print(responseJson);
//     print(responseJson['token']);
//     print(responseJson['user']);
//     return User.fromMap(responseJson['user']);
//  }catch(errr){
//     throw Exception(errr.message);
//  }
 return User((b) => b
      ..id='id'
      ..name='peter'
      ..profileIconUrl='url'
    );

}

Future<User> signInWithEmailAndPasword(email, password) async {
  // final FirebaseUser user =
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  // //final FirebaseUser currentUser = await _auth.currentUser();
  // return User(id:  user.uid, email: user.email, username: user.displayName,photoUrl:user.photoUrl);
//   try{
//     final response = await http.post(authUrl+'/login', headers: headers, body: {"email": email, "password": password});  
    
//     final responseJson = json.decode(response.body);
//     if (response.statusCode < 200 || response.statusCode >= 400) {
//         throw new Exception(responseJson['message']);
//       }
//     return User.fromMap(responseJson['user']);
//  }catch(err){
//     throw Exception(err.message);
//  }

return User((b) => b
      ..id='id'
      ..name='peter'
      ..profileIconUrl='url'
    );
}


Future<User> getUser(User user) async{


    return User((b) => b
      ..id='id $num'
      ..name='peter $num'
      ..profileIconUrl='url $num'
    );

}
}
