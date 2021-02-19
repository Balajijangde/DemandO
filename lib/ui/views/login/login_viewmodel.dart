import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:stacked/stacked.dart";
import "package:demando/AppConstants.dart";
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  final NavigationService _nav = locator<NavigationService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;

  String _title = "hello world";
  String get title => _title;

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  void setViewState(ViewState state) {
    this._viewState = state;
    notifyListeners();
  }

  String validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return "Phone is required";
    }
    if (value.length != 10 || double.tryParse(value) == null) {
      return "Invalid phone number";
    }
    return null;
  }

  void setPhoneNumber(String value) {
    this._phoneNumber = value;
  }

  void getOtp(GlobalKey<FormState> formkey) async {
    if (formkey.currentState.validate()) {
      this.setViewState(ViewState.Busy);
      formkey.currentState.save();
      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        //login logic will be here
        await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: "+91${this._phoneNumber}",
            verificationCompleted: (PhoneAuthCredential credential) async {
              // CAUTION below code is commented because we dont want automatic verification
              //  await _auth.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              // print("error from verificationFailed method");
              // print(e);
              this.setViewState(ViewState.Idle);
            },
            codeSent: (String verificationID, int resendToken) {
              print("code sent successfully");
              print(this._phoneNumber);
              this.setViewState(ViewState.Idle);
              _nav.navigateTo(OtpVerificationViewRoute, arguments: {
                "phoneNumber": this._phoneNumber,
                "verificationID": verificationID,
                "resendToken": resendToken
              });
            },
            codeAutoRetrievalTimeout: (String verificationID) {
              print("code auto retrieval timeout triggered");
            });
        //end of login logic

      } else {
        _snack.showSnackbar(message: "No Network Connection");
        this.setViewState(ViewState.Idle);
      }
    }
  }

  bool handleInputState() => this.viewState == ViewState.Idle ? true : false;
}
