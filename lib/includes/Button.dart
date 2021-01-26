import 'package:demando/AppConstants.dart';
import "package:flutter/material.dart";

class FilledButton extends StatelessWidget {
  final Widget title;
  final Function onTap;
  FilledButton(this.title, this.onTap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: 130.0,
        padding: EdgeInsets.symmetric(
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 5.0, color: Appblue),
          color: Appblue,
        ),
        child: title,
        // child: Text(
        //   title,
        //   style: TextStyle(
        //       color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.0),
        //   textAlign: TextAlign.center,
        // ),
      ),
    );
  }
}

class BorderedButton extends StatelessWidget {
  final String title;
  final Function onTap;
  BorderedButton(this.title, this.onTap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: 130.0,
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
        decoration: BoxDecoration(
          border: Border.all(width: 5.0, color: Appblue),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: Appgrey, fontWeight: FontWeight.w700, fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
