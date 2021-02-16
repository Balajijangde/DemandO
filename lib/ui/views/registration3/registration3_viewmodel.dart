import 'dart:io';
import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:demando/services/connectivity_service.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Registration3ViewModel extends BaseViewModel {
  final ConnectivityService _connectivity = locator<ConnectivityService>();
  final SnackbarService _snack = locator<SnackbarService>();
  final NavigationService _nav = locator<NavigationService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Database _firestore = Database();
  final _picker = ImagePicker();

  var _fileGettingMethods = Set<SimpleItem>()
    ..add(SimpleItem(1, "Take picture"))
    ..add(SimpleItem(2, "Upload from gallery"));

  File _aadhar;
  File get aadhar => _aadhar;

  File _gst;
  File get gst => _gst;

  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;
  void setViewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  String validateAadhar(String value) {
    if (value.isEmpty) {
      return "Aadhar is required";
    } else {
      return null;
    }
  }

  String validateGst(String value) {
    if (value.isEmpty) {
      return "GST is required";
    } else {
      return null;
    }
  }

  void selectAadhar(BuildContext context, TextEditingController controller) {
    if (this.viewState == ViewState.Idle) {
      radioListDialog(context, "Upload method", _fileGettingMethods,
          (item) async {
        if (item.toString() == "Take picture") {
          await this.takePictureForAadhar();
          if (_aadhar != null) {
            String filename = _aadhar.path.split('/').last;
            controller.text = filename;
          }
        } else if (item.toString() == "Upload from gallery") {
          await this.selectPictureForAadhar();
          if (_aadhar != null) {
            String filename = _aadhar.path.split('/').last;
            controller.text = filename;
          }
        }
      });
    }
  }

  Future takePictureForAadhar() async {
    final capturedAadhar = await _picker.getImage(source: ImageSource.camera);
    if (capturedAadhar != null) {
      this._aadhar = File(capturedAadhar.path);
    }
  }

  Future selectPictureForAadhar() async {
    final FilePickerResult selectedAadhar = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
        allowMultiple: false);
    if (selectedAadhar != null) {
      this._aadhar = File(selectedAadhar.files.single.path);
    }
  }

  void selectGst(BuildContext context, TextEditingController controller) {
    if (this.viewState == ViewState.Idle) {
      radioListDialog(context, "Upload method", _fileGettingMethods,
          (item) async {
        if (item.toString() == "Take picture") {
          await this.takePictureForGst();
          if (_gst != null) {
            String filename = _gst.path.split('/').last;
            controller.text = filename;
          }
        } else if (item.toString() == "Upload from gallery") {
          await this.selectPictureForGst();
          if (_gst != null) {
            String filename = _gst.path.split('/').last;
            controller.text = filename;
          }
        }
      });
    }
  }

  Future takePictureForGst() async {
    final capturedGst = await _picker.getImage(source: ImageSource.camera);
    if (capturedGst != null) {
      this._gst = File(capturedGst.path);
    }
  }

  Future selectPictureForGst() async {
    final FilePickerResult selectedGst = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
        allowMultiple: false);
    if (selectedGst != null) {
      this._gst = File(selectedGst.files.single.path);
    }
  }

  void completeRegistration3(
      GlobalKey<FormState> key,
      TextEditingController aadharController,
      TextEditingController gstController,
      BuildContext context) async {
    if (key.currentState.validate()) {
      this.setViewState(ViewState.Busy);
      bool connectionResult = await _connectivity.checkConnectivity();
      if (connectionResult) {
        try {
          await _firestore.reg3(_firebaseAuth.currentUser.uid, aadhar, gst);
          this.setViewState(ViewState.Idle);
          _nav.replaceWith(Registration4ViewRoute);
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
