import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final Widget child;
  final Function() onPressed;
  RoundedButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: (onPressed != null)?onPressed: (){},
            splashColor: Color(0Xfffa7c05),
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      colors: (onPressed!=null)?[Color(0Xfffa7c05), Color(0Xffee3e00)] :[Color(0Xffe0e0e0), Color(0Xffc0c0c0)])),
              child: child,
            ),
          );
  }
}