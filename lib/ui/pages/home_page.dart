import 'package:flutter/material.dart';
import 'package:sitcom_joke/ui/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('appBar'),),
        body: Text('Hello'),
        drawer: AppDrawer(),
    );
  }
}