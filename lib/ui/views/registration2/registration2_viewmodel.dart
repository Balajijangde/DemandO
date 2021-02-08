import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Registration2ViewModel extends BaseViewModel {
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final NavigationService _nav = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Database _firestore = Database();
  String _businessName = "";
  String get businessName => _businessName;
  void setBusinessName(String v) {
    this._businessName = v;
  }

  String _businessAddress = "";
  String get businessAddress => _businessAddress;
  void setBusinessAddress(String value) {
    this._businessAddress = value;
  }

  String _businessType = "";
  String get businessType => _businessType;
  void setBusinessType(String value, TextEditingController controller) {
    this._businessType = value;
    controller.text = value;
  }

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  String validateBusinessName(String value) {
    if (value.isEmpty) {
      return "Business name is required";
    } else if (value.length < 5 || value.length > 40) {
      return "Business Name should be between 5 to 40 characters";
    } else {
      return null;
    }
  }

  String validateBusinessAddress(String value) {
    if (value.isEmpty) {
      return "Business address is required";
    } else {
      return null;
    }
  }

  String validateBusinessType(String value) {
    if (value.isEmpty) {
      return "Business type is required";
    } else {
      return null;
    }
  }

  void completeRegistration2(GlobalKey<FormState> key,
      TextEditingController controller, BuildContext context) async {
    if (key.currentState.validate()) {
      this.setViewState(ViewState.Busy);
      key.currentState.save();
      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        try {
          await Future.delayed(Duration(seconds: 5));
          this.setViewState(ViewState.Idle);
          await _firestore.reg2(_firebaseAuth.currentUser.uid,
              this.businessName, this.businessAddress, this.businessType);
          _nav.navigateTo(Registration3ViewRoute);
        } catch (e) {
          errorDialog(context, e.toString());
          this.setViewState(ViewState.Idle);
        }
      } else {
        _snack.showSnackbar(message: "No Network Connection");
        this.setViewState(ViewState.Idle);
      }
    }
  }
}
