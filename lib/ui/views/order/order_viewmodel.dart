import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";

class OrderViewModel extends ChangeNotifier {
  final Database _data = Database();

  QuerySnapshot _orders;
  QuerySnapshot get orders => _orders;

  ViewState _viewState = ViewState.Busy;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }

  void fetchOrders() async {
    try {
      QuerySnapshot result =
          await _data.fetchOrders(FirebaseAuth.instance.currentUser.uid);
      this._orders = result;
      this.setViewState(ViewState.Idle);
    } catch (e) {
      print(e);
      this.setViewState(ViewState.Idle);
    }
  }
}
