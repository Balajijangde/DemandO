import 'package:demando/AppConstants.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }
}
