import 'package:test/test.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';

void main(){
  
  
  test('check accept change', (){

    ApplicationBloc appBloc = ApplicationBloc();
    appBloc.changeTitle('hello');
    expect(appBloc.appTitle, emitsInOrder(['Sitcom', 'hello']));
  });
}