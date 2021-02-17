import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Registration1ViewModel extends BaseViewModel {
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final NavigationService _nav = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Database _firestore = Database();
  DateTime _dob;
  DateTime get dob => _dob;
  void setDob(DateTime dob) {
    this._dob = dob;
  }

  String _name = "";
  String get name => _name;
  void setName(String value) {
    this._name = value;
  }

  String _email = "";
  String get email => _email;
  void setEmail(String value) {
    this._email = value;
  }

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  void showDialog(BuildContext context) {
    errorDialog(
      context,
      "Success message",
    );
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return "Name is required";
    } else if (value.length < 5 || value.length > 40) {
      return "Name should be between 5 to 40 characters";
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(
            r"^[a-zA-Z0-9\+\.\_\%\-\+]{3,256}@[a-zA-Z0-9\-]{2,64}(\.[a-zA-Z\-]{2,25}){0,64}\.[a-zA-Z\-]{2,25}$")
        .hasMatch(value)) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  String validateDob(String value) {
    if (value.isEmpty) {
      return "DOB is required";
    } else {
      return null;
    }
  }

  void completeRegistration1(GlobalKey<FormState> key,
      TextEditingController controller, BuildContext context) async {
    if (key.currentState.validate()) {
      this.setViewState(ViewState.Busy);
      key.currentState.save();
      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        try {
          await _firestore.reg1(
              _firebaseAuth.currentUser.uid, this.name, this.email, this.dob);
          // await _firebaseAuth.currentUser.updateProfile(displayName: this.name);
          // await _firebaseAuth.currentUser.updateEmail(this.email);
          this.setViewState(ViewState.Idle);
          _nav.replaceWith(Registration2ViewRoute);
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

  Future<bool> cancelRegistration(context) {
    warningDialog(context,
        "You can't place orders without completing regitration, do you really want to cancel registration",
        positiveText: "Cancel",
        negativeText: "Yes",
        showNeutralButton: false,
        positiveAction: () => {},
        negativeAction: () => _nav.back());
  }
}
