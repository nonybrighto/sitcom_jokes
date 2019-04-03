import 'dart:convert' as json;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
 

  static Serializer<User> get serializer => _$userSerializer;

  String get id;
  String get username;
  @nullable
  String get profileIconUrl;
  @nullable
  String get email;

  factory User([updates(UserBuilder b)]) = _$User;
  User._();


  factory User.fromJson( Map<String, dynamic> json){

    //final parsed = json.jsonDecode(jsonString);
    User user = standardSerializers.deserializeWith(User.serializer, json);
    return user;
  }

  bool hasFullDetails(){
    return true;
  }

}
