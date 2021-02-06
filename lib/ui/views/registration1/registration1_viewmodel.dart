import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class Registration1ViewModel extends BaseViewModel {
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
    } else if (value.contains(Patterns.PATTERN_EMAIL) != true) {
      return "Enter valid email";
    } else {
      return null;
    }
  }

  void completeRegistration1(
      GlobalKey<FormState> key, TextEditingController controller) async {
    key.currentState.validate();
  }
}
