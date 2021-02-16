import 'package:demando/AppConstants.dart';
import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  OrderView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appblue,
        centerTitle: true,
        title: Text(
          "My Orders",
          style: TextStyle(fontSize: HeadingSize, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
