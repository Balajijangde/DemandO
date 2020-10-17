import 'package:demando/AppConstants.dart';
import 'package:demando/includes/Button.dart';
import 'package:demando/screens/SignupScreen.dart';
import "package:flutter/material.dart";

class SigninScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SigninScreenState();
  }
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> signinformkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PageSidePadding),
          child: Column(
            children: [
              SizedBox(height: 100.0),
              Image.asset("images/logo2.png", width: 100.0),
              SizedBox(height: 30.0),
              Text(
                "Sign In",
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 8.0),
              Text(
                "You can use your fingerprint \nto grant access to your app.",
                style: TextStyle(fontSize: 12.0, color: Appgrey),
              ),
              SizedBox(height: 40.0),
              Form(
                key: signinformkey,
                child: Column(children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(height: 40.0),
                  FilledButton("Log In", () {})
                ]),
              ),
              SizedBox(height: 10.0),
              Text(
                "Forgot Password?",
                style: TextStyle(
                    color: Appblue, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Still without account? ",
                      style: TextStyle(color: Appgrey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreenRoute);
                    },
                    child: Text("Create one", style: TextStyle(color: Appblue)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
