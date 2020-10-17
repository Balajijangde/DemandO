import 'package:demando/AppConstants.dart';
import "package:flutter/material.dart";

class Heading3 extends StatelessWidget {
  final String title;
  Heading3(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(this.title,
          style: TextStyle(
              color: Appblue, fontWeight: FontWeight.w900, fontSize: 18.0)),
    );
  }
}
