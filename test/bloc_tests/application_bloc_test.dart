import 'package:sitcom_joke/constants/constants.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:test/test.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';

void main(){
  
  
  test('check accept change', (){

    ApplicationBloc appBloc = ApplicationBloc();
    appBloc.changeAppTitle('hello');
    expect(appBloc.appTitle, emitsInOrder([kAppName, 'hello']));
  });

  test('isAuthenticated is true when current user changes', (){

    ApplicationBloc appBloc = ApplicationBloc();
    User user = User((b) => b
      ..id='id'
      ..name='peter'
      ..profileIconUrl='url'
    );
    appBloc.changeCurrentUser(user);

    expect(appBloc.currentUser, emits(user));
    expect(appBloc.isAuthenticated, emitsInOrder([false, true]));
  });

  
  test('isAuthenticated is false when current user is null', (){

    ApplicationBloc appBloc = ApplicationBloc();
   
    appBloc.changeCurrentUser(null);
    expect(appBloc.isAuthenticated, emitsInOrder([false, false]));
  });


}