import 'package:connectivity/connectivity.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/includes/Button.dart';
import 'package:demando/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SigninScreenState();
  }
}

class _SigninScreenState extends State<SigninScreen> {
  String phonenumber = "";
  bool phonesupplied = false;
  String otp = "";
  String verificationID = "";
  int resendToken = 0;
  bool isBusy = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  void getOTP() async {
    setState(() {
      this.isBusy = true;
    });
    await auth.verifyPhoneNumber(
        phoneNumber: "+91$phonenumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          //comment below to disable automatic verification
          // await auth.signInWithCredential(credential);
          //       setState(() {
          //   this.isBusy = true;
          // });
          // Navigator.pushReplacementNamed(context, LandingScreenRoute);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          setState(() {
            this.isBusy = false;
          });
        },
        codeSent: (String verificationID, int resendToken) async {
          print("codesent method triggered");
          setState(() {
            this.phonesupplied = true;
            this.phonenumber = "";
            this.verificationID = verificationID;
            this.resendToken = resendToken;
            this.isBusy = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          print("code auto retrival timeout triggered");
        });
  }

  void verifyOTP() async {
    Database data = Database();
    setState(() {
      this.isBusy = true;
    });
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.verificationID, smsCode: this.otp);
    try {
      await auth.signInWithCredential(phoneAuthCredential);
      data.userInitialization(FirebaseAuth.instance.currentUser.uid);
      setState(() {
        this.isBusy = false;
      });
      Navigator.pushReplacementNamed(context, LandingScreenRoute);
    } catch (e) {
      print("got some error :$e");
      setState(() {
        this.isBusy = false;
      });
    }
  }

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
              !this.phonesupplied
                  ? (Column(children: [
                      TextField(
                        onChanged: (String value) {
                          phonenumber = value;
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "10 digit phone number",
                        ),
                      ),
                      SizedBox(height: 40.0),
                      this.isBusy
                          ? (CircularProgressIndicator())
                          : (FilledButton(
                              Text("Receive OTP",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0)),
                              getOTP))
                    ]))
                  : (Column(children: [
                      TextField(
                        onChanged: (String value) {
                          otp = value;
                        },
                        maxLength: 6,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "6 digit one time password",
                        ),
                      ),
                      SizedBox(height: 40.0),
                      this.isBusy
                          ? (CircularProgressIndicator())
                          : (FilledButton(
                              Text(
                                "Verify OTP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              verifyOTP)),
                    ]))
              // SizedBox(height: 10.0),
              // Text(
              //   "Forgot Password?",
              //   style: TextStyle(
              //       color: Appblue, decoration: TextDecoration.underline),
              // ),
              // SizedBox(height: 40.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Still without account? ",
              //         style: TextStyle(color: Appgrey)),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pushNamed(context, SignupScreenRoute);
              //       },
              //       child: Text("Create one", style: TextStyle(color: Appblue)),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
