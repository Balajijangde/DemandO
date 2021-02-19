import 'package:commons/commons.dart';
import 'package:connectivity/connectivity.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';
import "package:demando/AppConstants.dart";
import 'package:stacked_services/stacked_services.dart';

class ProductViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _snack = locator<SnackbarService>();
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  String productId;
  String productName;
  double productPrice;
  int productQuantity;
  double productTotal;
  bool expanded = false;

  void expandTile(var connectionProvider) {
    if (this.expanded == true) {
      this.expanded = false;
      notifyListeners();
    } else if (connectionProvider.data == null) {
      _snack.showSnackbar(message: "No Network Connection");
    } else if (connectionProvider.data.value == ConnectivityResult.none) {
      _snack.showSnackbar(message: "No Network Connection");
    } else if (connectionProvider.data.value == ConnectivityResult.mobile ||
        connectionProvider.data.value == ConnectivityResult.wifi) {
      this.expanded = !this.expanded;
      notifyListeners();
    } else {
      _snack.showSnackbar(message: "No Network Connection");
    }
  }

  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }

  String validateQuantity(String v) {
    if (v.isEmpty) {
      return "Quantity is required";
    } else if (int.tryParse(v) == null) {
      return "Invalid Quantity";
    } else if (double.parse(v) > 999 || int.parse(v) < 1) {
      return "Quantity should between 1 to 999";
    } else {
      return null;
    }
  }

  void setProduct(
      String id, String name, int quantity, double total, double price) {
    this.productId = id;
    this.productName = name;
    this.productPrice = price;
    this.productQuantity = quantity;
    this.productTotal = total;
  }

  Future showProductCheckoutBottomSheet(GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        if (FirebaseAuth.instance.currentUser != null) {
          await _bottomSheetService.showCustomSheet(
              variant: BottomSheetType.ProductCheckout,
              customData: {
                "productId": this.productId,
                "productName": this.productName,
                "productPrice": this.productPrice,
                "productQuantity": this.productQuantity,
                "productTotal": this.productTotal
              });
        } else {
          _snack.showSnackbar(message: "Please login ");
        }
      } else {
        _snack.showSnackbar(message: "No Network Connection");
      }
    }
  }

  void showLoginDialog(BuildContext context) {
    infoDialog(context,
        "Login required for placing orders, please consider logging in",
        positiveText: "Login", positiveAction: () {
      _nav.navigateTo(LoginViewRoute);
    });
  }

  Color getProductBackgroundColor(dynamic provider) {
    if (provider.data == null) {
      return Colors.grey[200];
    } else if (provider.data.value == ConnectivityResult.none) {
      return Colors.grey[200];
    } else if (provider.data.value == ConnectivityResult.mobile ||
        provider.data.value == ConnectivityResult.wifi) {
      return Colors.white;
    } else {
      return Colors.grey[200];
    }
  }
}
