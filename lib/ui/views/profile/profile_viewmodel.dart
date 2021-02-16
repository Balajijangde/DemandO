import 'package:flutter/material.dart';
import "package:demando/AppConstants.dart";

class ProfileViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }
}
