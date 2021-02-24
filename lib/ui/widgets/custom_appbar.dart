import 'package:demando/AppConstants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget leading;
  final Widget actions;
  final TabController tabController;
  final Widget navigationRow;
  CustomAppBar(
      {this.leading, this.actions, this.tabController, this.navigationRow});
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, 130);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: widget.preferredSize.height,
          color: Appblue,
          child: Row(
            children: [
              widget.leading,
              Expanded(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Demand",
                      style: TextStyle(
                          fontSize: HeadingSize, fontWeight: normalBold),
                      children: <TextSpan>[
                        TextSpan(
                            text: "O",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: normalBold,
                                fontSize: HeadingSize))
                      ]),
                ),
              ),
              widget.actions
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                width: double.infinity,
                height: 20,
              ),
              Container(
                height: 15,
                color: Colors.grey[50],
                width: double.infinity,
              )
            ])),
        Positioned(
            left: 10,
            right: 10,
            bottom: 0,
            height: 60,
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1.5,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.grey[50]),
                child: widget.navigationRow))
      ],
    ));
  }
}
