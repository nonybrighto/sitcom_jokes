import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitcom_joke/constants/constants.dart';

Future<Options> getAuthHeaderOption() async{

  SharedPreferences pref  = await SharedPreferences.getInstance();

  String userJwtToken = await pref.get(kUserJwtTokenPrefKey);
  return Options(
    headers: {
      HttpHeaders.authorizationHeader: 'jwt $userJwtToken' , // set content-length
    },
  );
}