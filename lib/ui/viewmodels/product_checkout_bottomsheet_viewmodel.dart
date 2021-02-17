import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:demando/ui/views/order/order_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import "package:firebase_auth/firebase_auth.dart";

class ProductCheckoutBottomSheetViewModel extends BaseViewModel {
  final ConnectivityService _connection = locator<ConnectivityService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final Database _data = Database();
  final NavigationService _nav = locator<NavigationService>();

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }

  String _passkey;
  String get passkey => _passkey;
  void setPasskey(String v) {
    this._passkey = v;
  }

  String _orderId;
  String get orderId => _orderId;
  void setOrderId(String v) {
    this._orderId = v;
  }

  bool _orderPlaced = false;
  bool get orderPlaced => _orderPlaced;
  void placeOrderSuccessfully() {
    this._orderPlaced = true;
    notifyListeners();
  }

  String validatePasskey(String v) {
    if (v.isEmpty) {
      return "passkey is required";
    } else if (v.length != 4) {
      return "passkey should be of 4 characters";
    } else if (int.parse(v) == null) {
      return "invalid passkey";
    } else {
      return null;
    }
  }

  Future placeOrder(GlobalKey<FormState> key, productId, productName, price,
      quantity, total, context) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      this.setViewState(ViewState.Busy);
      var result = await _connection.checkConnectivity();
      if (result == true) {
        DocumentReference result = await _data.placeOrder(
            FirebaseAuth.instance.currentUser.uid,
            productId,
            productName,
            passkey,
            price,
            quantity,
            total,
            context);
        if (result == null) {
          this.setViewState(ViewState.Idle);
        }
        if (result != null) {
          this.setOrderId(result.id);
          this.placeOrderSuccessfully();
        }
      } else {
        _snack.showSnackbar(message: "No Network Connection");
        this.setViewState(ViewState.Idle);
      }
    }
  }

  void navigateToOrders() {
    _nav.back();
    _nav.navigateTo(OrderViewRoute);
  }
}
