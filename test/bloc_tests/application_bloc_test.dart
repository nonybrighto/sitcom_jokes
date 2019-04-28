import 'package:sitcom_joke/constants/constants.dart';
import 'package:test/test.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';

void main(){
  
  
  test('check accept change', (){

    ApplicationBloc appBloc = ApplicationBloc();
    appBloc.changeAppTitle('hello');
    expect(appBloc.appTitle, emitsInOrder([kAppName, 'hello']));
  });
}