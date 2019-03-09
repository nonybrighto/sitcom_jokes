import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/user_service.dart';

class  UserDetailsBloc extends BlocBase {
 
 User currentUser;
 UserService userService;

  final _userController = BehaviorSubject<User>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _getUserDetailsController = StreamController<Null>();


  //stream
  Stream<LoadState> get loadState => _loadStateController.stream;
  Stream<User> get user => _userController.stream;

  //sink
  void Function() get getUserDetails => () => _getUserDetailsController.sink.add(null);


 UserDetailsBloc({this.currentUser, this.userService}){

    _userController.sink.add(currentUser);
     if(!currentUser.hasFullDetails()){
           getUserDetails();
        }else{
           _loadStateController.sink.add(Loaded());
        }

         _getUserDetailsController.stream.listen((_){
            _getUserFromSource();
      });



 }
 
 _getUserFromSource() async{
    _loadStateController.sink.add(Loading());
        try{
            User userGotten = await userService.getUser(currentUser);
             currentUser  = userGotten;
            _userController.sink.add(userGotten);
            _loadStateController.sink.add(Loaded());
        }catch(err){
            _loadStateController.sink.add(LoadError('Could not get user Details'));
        }
  }
 
 
  @override
  void dispose() {
    _userController.close();
    _loadStateController.close();
    _getUserDetailsController.close();
  }
  
}