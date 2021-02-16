import 'package:commons/commons.dart';
import 'package:demando/services/Database.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:demando/ui/views/registration1/registration1_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:demando/AppConstants.dart';

class OtpVerificationViewModel extends BaseViewModel {
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  final NavigationService _nav = locator<NavigationService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final DialogService _dialog = locator<DialogService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Database _firestore = Database();

  String _phoneNumber;
  String get phoneNumber => _phoneNumber;
  String _verificationID;
  String get verificationID => _verificationID;
  int _resendToken;
  int get resendToken => _resendToken;
  void setArgs(String phoneNumber, String verificationID, int resendToken) {
    this._phoneNumber = phoneNumber;
    this._verificationID = verificationID;
    this._resendToken = resendToken;
  }

  String _otp = "";
  String get otp => this._otp;
  void setOtp(String value) {
    this._otp = value;
  }

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  void setViewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  bool handleInputState() => this.viewState == ViewState.Busy ? false : true;

  String validateOtp(String value) {
    if (value.isEmpty) {
      return "Otp is required";
    } else if (value.length != 6) {
      return "Otp should be of 6 characters";
    } else if (double.tryParse(value) == null) {
      return "Invalid Otp type";
    } else {
      return null;
    }
  }

  void verifyOtp(GlobalKey<FormState> key, String phoneNumber,
      String verificationID, int resentToken, BuildContext context) async {
    this.setArgs(phoneNumber, verificationID, resendToken);
    if (key.currentState.validate()) {
      this.setViewState(ViewState.Busy);
      key.currentState.save();
      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        PhoneAuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: this.verificationID, smsCode: this.otp);
        try {
          await _firebaseAuth.signInWithCredential(_phoneAuthCredential);
          bool result = await _firestore
              .userInitialization(FirebaseAuth.instance.currentUser.uid);
          this.setViewState(ViewState.Idle);

          if (result) {
            _nav.popRepeated(2);
            _nav.navigateTo(Registration1ViewRoute);
            _snack.showSnackbar(
                message: "Successfully logged in as +91 $phoneNumber");
          } else {
            // _nav.navigateTo(LandingScreenRoute);
            _nav.popRepeated(2);
            _snack.showSnackbar(
                message: "Successfully logged in as +91 $phoneNumber");
          }
        } catch (e) {
          errorDialog(context, "Wrong OTP Provided");

          this.setViewState(ViewState.Idle);
        }
      } else {
        _snack.showSnackbar(message: "No Network Connection");
        this.setViewState(ViewState.Idle);
      }
    }
  }
}
