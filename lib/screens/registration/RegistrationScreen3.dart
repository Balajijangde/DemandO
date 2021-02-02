import 'package:demando/AppConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "dart:io";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:file_picker/file_picker.dart";
import "package:demando/services/Database.dart";

class RegistrationScreen3 extends StatefulWidget {
  RegistrationScreen3({Key key}) : super(key: key);

  @override
  _RegistrationScreen3State createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  File aadhar;
  File gst;
  bool gotAadhar = false;
  bool gotGst = false;
  bool isBusy = false;
  final picker = ImagePicker();

  void takePictureForAadhar() async {
    final capturedAadhar = await picker.getImage(source: ImageSource.camera);
    if (capturedAadhar != null) {
      setState(() {
        aadhar = File(capturedAadhar.path);
        gotAadhar = true;
      });
    }
  }

  void selectPictureForAadhar() async {
    final FilePickerResult selectedAadhar = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
        allowMultiple: false);
    if (selectedAadhar != null) {
      setState(() {
        aadhar = File(selectedAadhar.files.single.path);
        gotAadhar = true;
      });
    }
  }

  void takePictureForGst() async {
    final capturedGst = await picker.getImage(source: ImageSource.camera);
    if (capturedGst != null) {
      setState(() {
        gst = File(capturedGst.path);
        gotGst = true;
      });
    }
  }

  void selectPictureForGst() async {
    final FilePickerResult selectedGst = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
        allowMultiple: false);
    if (selectedGst != null) {
      setState(() {
        gst = File(selectedGst.files.single.path);
        gotGst = true;
      });
    }
  }

  void uploadFiles() async {
    setState(() {
      isBusy = true;
    });
    Database data = Database();
    await data.reg3(
        FirebaseAuth.instance.currentUser.uid, this.aadhar, this.gst);
    Navigator.pushNamed(context, RegistrationScreen4Route);
    // try {
    //   var result = await firebase_storage.FirebaseStorage.instance
    //       .ref(
    //           'aadhar/${FirebaseAuth.instance.currentUser.uid}/aadhar.${aadhar.path.split('.').last}')
    //       .putFile(aadhar);
    //   var result2 = await firebase_storage.FirebaseStorage.instance
    //       .ref(
    //           'gst/${FirebaseAuth.instance.currentUser.uid}/gst.${gst.path.split('.').last}')
    //       .putFile(gst);
    //   print("result");
    //   print(result);
    //   print(result2);
    // } catch (e) {
    //   print("error occured");
    //   print(e);
    // }
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Aadhar",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0),
            ),
            gotAadhar
                ? Icon(Icons.done)
                : (Row(
                    children: [
                      ElevatedButton(
                          onPressed: takePictureForAadhar,
                          child: Text("Take picture")),
                      ElevatedButton(
                          onPressed: selectPictureForAadhar,
                          child: Text("Open gallery"))
                    ],
                  )),
            Text(
              "GST",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0),
            ),
            gotGst
                ? Icon(Icons.done)
                : (Row(
                    children: [
                      ElevatedButton(
                          onPressed: takePictureForGst,
                          child: Text("Take picture")),
                      ElevatedButton(
                          onPressed: selectPictureForGst,
                          child: Text("Open gallery"))
                    ],
                  )),
            ElevatedButton(
                onPressed: () {
                  print(aadhar.path.split('.').last);
                  print(gst.path.split('.').last);
                },
                child: Text("check status")),
            isBusy
                ? (CircularProgressIndicator())
                : (ElevatedButton(
                    onPressed: uploadFiles, child: Text("Upload")))
          ],
        ),
      ),
    );
  }
}
