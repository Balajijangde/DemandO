import 'package:demando/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import '../../AppConstants.dart';

class RegistrationScreen2 extends StatefulWidget {
  RegistrationScreen2({Key key}) : super(key: key);

  @override
  _RegistrationScreen2State createState() => _RegistrationScreen2State();
}

class _RegistrationScreen2State extends State<RegistrationScreen2> {
  final GlobalKey<FormState> reg2key = GlobalKey<FormState>();
  String businessName;
  String businessAddress;
  String businessType;
  bool isBusy = false;

  void completeRegistration2() {
    setState(() {
      isBusy = true;
    });
    Database data = Database();
    data.reg2(FirebaseAuth.instance.currentUser.uid, this.businessName,
        this.businessAddress, this.businessType);
    setState(() {
      isBusy = false;
    });
    Navigator.pushNamed(context, RegistrationScreen3Route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Business Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0),
            ),
            Form(
              key: reg2key,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (String value) {
                      businessName = value;
                    },
                    decoration: InputDecoration(labelText: "Business Name"),
                  ),
                  TextFormField(
                    onSaved: (String value) {
                      businessAddress = value;
                    },
                    decoration: InputDecoration(labelText: "Business address"),
                  ),
                  TextFormField(
                    onSaved: (String value) {
                      businessType = value;
                    },
                    decoration: InputDecoration(labelText: "Business type"),
                  ),
                  RaisedButton(
                      child: Text("Next"),
                      onPressed: () {
                        reg2key.currentState.save();
                        completeRegistration2();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
