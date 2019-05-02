import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/user_details_bloc.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/user_service.dart';

class UserSettingsBloc extends BlocBase{
 
 
  UserService userService;

  final _changeUserPhotoController = StreamController<File>();
  final _loadStateController = BehaviorSubject<LoadState>();

  void Function(File) get changeUserPhoto => (photo) => _changeUserPhotoController.sink.add(photo);

  Stream<LoadState> get loadState => _loadStateController.stream;

  UserSettingsBloc({this.userService, AuthBloc authBloc, UserDetailsBloc userDetailsBloc}){

      _loadStateController.sink.add(Loaded());

      _changeUserPhotoController.stream.listen((photo) async{

        _loadStateController.sink.add(Loading());
         User updatedUser = await userService.changeUserPhoto(photo: photo);
         authBloc.changeCurrentUser(updatedUser);
         userDetailsBloc?.updateUser(updatedUser);
        _loadStateController.sink.add(LoadEnd());
      });
  }
 
  @override
  void dispose() {
    _changeUserPhotoController.close();
    _loadStateController.close();
  }


}