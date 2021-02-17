import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TempWidget extends StatefulWidget {
  const TempWidget({Key key, this.product}) : super(key: key);
  final QueryDocumentSnapshot product;

  @override
  _TempWidgetState createState() => _TempWidgetState(product: this.product);
}

class _TempWidgetState extends State<TempWidget> {
  final QueryDocumentSnapshot product;
  _TempWidgetState({this.product});
  @override
  Widget build(BuildContext context) {
    return Text(product.get("price").toString());
  }
}
