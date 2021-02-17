import 'package:commons/commons.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import "package:demando/AppConstants.dart";
import 'package:stacked_services/stacked_services.dart';

class ProductViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  String productId;
  String productName;
  double productPrice;
  int productQuantity;
  double productTotal;

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
      var sheetResponse = await _bottomSheetService.showCustomSheet(
          variant: BottomSheetType.ProductCheckout,
          customData: {
            "productId": this.productId,
            "productName": this.productName,
            "productPrice": this.productPrice,
            "productQuantity": this.productQuantity,
            "productTotal": this.productTotal
          });
    }
  }

  void showLoginDialog(BuildContext context) {
    infoDialog(context,
        "Login required for placing orders, please consider logging in",
        positiveText: "Login", positiveAction: () {
      _nav.navigateTo(LoginViewRoute);
    });
  }
}
