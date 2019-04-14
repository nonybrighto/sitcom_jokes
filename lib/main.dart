import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/ui/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Color(0XFF212845),
              accentColor: Color(0XFFfc6b00),
              scaffoldBackgroundColor: Color(0XFF212845),
              primarySwatch: Colors.orange,
              buttonColor: Color(0XFFfc6b00),
              canvasColor: Color(0XFF212845),
              dividerColor: Color(0XFFC0c0c0)
            ),
            home: HomePage(),
          ),
          bloc: ApplicationBloc(),
    );
  }
}

