import 'package:demando/AppConstants.dart';
import "package:flutter/material.dart";
import "package:demando/services/Database.dart";
import "package:firebase_auth/firebase_auth.dart";

class RegistrationScreen4 extends StatefulWidget {
  RegistrationScreen4({Key key}) : super(key: key);

  @override
  _RegistrationScreen4State createState() => _RegistrationScreen4State();
}

class _RegistrationScreen4State extends State<RegistrationScreen4> {
  String passkey = "";
  bool isBusy = false;
  void completeReg4() async {
    setState(() {
      isBusy = true;
    });
    Database data = Database();
    await data.reg4(FirebaseAuth.instance.currentUser.uid, passkey);
    setState(() {
      isBusy = false;
    });
    Navigator.pushNamed(context, LandingScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Create passkey"),
            TextField(
              onChanged: (String value) {
                passkey = value;
              },
              decoration: InputDecoration(labelText: "passkey here"),
            ),
            isBusy
                ? (CircularProgressIndicator())
                : (ElevatedButton(
                    onPressed: completeReg4, child: Text("submit")))
          ],
        ),
      ),
    );
  }
}
