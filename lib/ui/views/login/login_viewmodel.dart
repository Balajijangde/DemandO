import "package:stacked/stacked.dart";
import "package:demando/AppConstants.dart";

class LoginViewModel extends BaseViewModel {
  String _title = "hello world";
  String get title => _title;

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  void setViewState(ViewState state) {
    this._viewState = state;
    notifyListeners();
  }

  void testFunction() async {
    this.setViewState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 5));
    this.setViewState(ViewState.Idle);
  }
}
