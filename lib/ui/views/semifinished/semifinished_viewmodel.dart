import 'package:demando/AppConstants.dart';
import 'package:stacked/stacked.dart';

class SemiFinishedViewModel extends BaseViewModel {
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }
}
