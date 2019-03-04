import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {

  final String errorMessage;
  final String buttonText;
  final Function errorTap;
 
  MainErrorWidget({this.errorMessage, this.buttonText, this.errorTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[
            Text(this.errorMessage ?? 'Error occured'),
            RaisedButton(
                child: Text(buttonText ?? 'RETRY'),
                onPressed: errorTap,
            ),
          ],
        ),
    );
  }
}