import 'package:demando/AppConstants.dart';
import "package:flutter/material.dart";

class AppButton2 extends StatelessWidget {
  final String title;
  final Function onPressed;
  const AppButton2({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: AppLightGrey,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Appblue, fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}