import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Registration4ViewModel extends BaseViewModel {
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final NavigationService _nav = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Database _firestore = Database();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  String _passkey;
  String get passkey => _passkey;
  void setPasskey(String v) {
    this._passkey = v;
  }

  String validatePasskey(String value) {
    if (value.isEmpty) {
      return "Passkey is required";
    } else if (value.length != 4) {
      return "Pssskey should be of 4 characters";
    } else {
      return null;
    }
  }

  void completeRegistration4(
      GlobalKey<FormState> key, BuildContext context) async {
    if (key.currentState.validate()) {
      key.currentState.save();
      this.setViewState(ViewState.Busy);

      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        try {
          await _firestore.reg4(_firebaseAuth.currentUser.uid, passkey);
          final DocumentReference userData = _firebaseFirestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid);
          dynamic result = await userData.get();
          this.setViewState(ViewState.Idle);
          _nav.replaceWith(ProfileViewRoute, arguments: result);

          _snack.showSnackbar(
              message: "Now, your documents are under manual verification.");
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

  Future<void> cancelRegistration(context) {
    warningDialog(context,
        "You can't place orders without completing regitration, do you really want to cancel registration",
        positiveText: "Cancel",
        negativeText: "Yes",
        showNeutralButton: false,
        positiveAction: () => {},
        negativeAction: () => _nav.back());
  }
}
