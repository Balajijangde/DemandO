import 'package:demando/AppConstants.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:demando/ui/views/registration1/registration1_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import "package:commons/commons.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class LandingViewModel extends ChangeNotifier {
  final NavigationService _nav = locator<NavigationService>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState v) {
    this._viewState = v;
    notifyListeners();
  }

  void navigateToProfile(BuildContext context) async {
    _nav.back();
    final DocumentReference userData = _firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);
    waitDialog(context);
    try {
      dynamic result = await userData.get();
      switch (result["status"]) {
        case "registration 1":
          _nav.back();
          _nav.navigateTo(Registration1ViewRoute);
          break;
        case "registration 2":
          _nav.back();
          _nav.navigateTo(Registration2ViewRoute);
          break;
        case "registration 3":
          _nav.back();
          _nav.navigateTo(Registration3ViewRoute);
          break;
        case "registration 4":
          _nav.back();
          _nav.navigateTo(Registration4ViewRoute);
          break;
        default:
          _nav.back();
          _nav.navigateTo(ProfileViewRoute);
      }
    } catch (e) {
      print(e);
      _nav.back();
    }
  }
}
