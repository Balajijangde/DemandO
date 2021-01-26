import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:demando/AppConstants.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String user = "none";
  @override
  void initState() {
    super.initState();
    this.auth.authStateChanges().listen((User user) {
      if (user != null) {
        print(user);
        setState(() {
          this.user = user.uid;
        });
      } else {
        setState(() {
          this.user = "none";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landing screen"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "This is our landing screen",
              textAlign: TextAlign.center,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, SigninScreenRoute);
                },
                child: Text("Go to Authenticaton area")),
            Text(
              "authentication : $user",
              textAlign: TextAlign.center,
            ),
            FlatButton(
                onPressed: () async {
                  await auth.signOut();
                },
                child: Text("signout"))
          ]),
    );
  }
}
