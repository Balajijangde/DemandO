import 'package:demando/AppConstants.dart';
import 'package:demando/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class RegistrationScreen1 extends StatefulWidget {
  RegistrationScreen1({Key key}) : super(key: key);

  @override
  _RegistrationScreen1State createState() => _RegistrationScreen1State();
}

class _RegistrationScreen1State extends State<RegistrationScreen1> {
  String name;
  String email;
  DateTime dob;
  bool isBusy = false;
  void completeRegistration1() {
    setState(() {
      isBusy = true;
    });
    Database _data = Database();
    _data.reg1(
        FirebaseAuth.instance.currentUser.uid, this.name, this.email, this.dob);
    setState(() {
      isBusy = false;
    });
    Navigator.pushNamed(context, RegistrationScreen2Route);
  }

  final GlobalKey<FormState> reg1key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Personal Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0),
            ),
            Form(
              key: reg1key,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (String value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                  TextFormField(
                    onSaved: (String value) {
                      email = value;
                    },
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  InputDatePickerFormField(
                    onDateSaved: (DateTime value) {
                      dob = value;
                    },
                    firstDate: DateTime(1901),
                    lastDate: DateTime.now(),
                  ),
                  isBusy
                      ? (CircularProgressIndicator())
                      : (RaisedButton(
                          child: Text("Next"),
                          onPressed: () {
                            reg1key.currentState.save();

                            completeRegistration1();
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
