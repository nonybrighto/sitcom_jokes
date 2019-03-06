import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/models/bloc_delegate.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/user_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../general_mocks.dart';
import '../type_matchers.dart';



User successUser;
String errorMessage;
class DelegateMock extends BlocDelegate<User>{
  @override
  error(String message) {
    errorMessage = message;
  }

  @override
  success(User user) {
    successUser = user;
  }
 

}

void main(){

  UserService userService = MockUserService();
  test('call success delegate and set currentUser when login success', () async{

    User user = User((b) => b
      ..id='123a'
      ..name='john'
      ..profileIconUrl='theurl'
    );

    when(userService.signInWithEmailAndPasword('john@email.com', 'password123')).thenAnswer((_) async =>  user);

    DelegateMock delegateMock = new DelegateMock();
    AuthBloc authBloc = AuthBloc(userService: userService, delegate: delegateMock);
    authBloc.login('john@email.com', 'password123');
    
    expect(authBloc.loadState, emitsInOrder([loaded, loading, loaded]));

    await Future.delayed(Duration(seconds: 3));
    expect(successUser, user);
    verify(userService.signInWithEmailAndPasword('john@email.com', 'password123'));
  });

  test('call error delegate when error in login process', () async{

    when(userService.signInWithEmailAndPasword('john@email.com', 'password123')).thenAnswer((_)  =>  Future.error('error occured'));

    DelegateMock delegateMock = new DelegateMock();
    AuthBloc authBloc = AuthBloc(userService: userService, delegate: delegateMock);
    authBloc.login('john@email.com', 'password123');
    
    expect(authBloc.loadState, emitsInOrder([loaded, loading, loadError]));
    await Future.delayed(Duration(seconds: 3));
    expect(errorMessage, 'error occured');
    verify(userService.signInWithEmailAndPasword('john@email.com', 'password123'));

  });
}