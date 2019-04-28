import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/services/auth_service.dart';
import 'package:sitcom_joke/ui/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
          child: BlocProvider<AuthBloc>(
                      bloc: AuthBloc(authService: AuthService()),
                      child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0XFF212845),
                accentColor: const Color(0XFFfc6b00),
                scaffoldBackgroundColor:const  Color(0XFF212845),
                primarySwatch: Colors.orange,
                buttonColor: const Color(0XFFfc6b00),
                canvasColor: const Color(0XFF212845),
                dividerColor: const Color(0XFF676b67),
                cardColor: const Color(0X252836),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.accent
                )
              ),
              home: HomePage(),
            ),
          ),
          bloc: ApplicationBloc(),
    );
  }
}

