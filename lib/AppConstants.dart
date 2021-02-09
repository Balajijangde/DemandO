import "package:flutter/material.dart";

//Universal settings
const double PageSidePadding = 30.0;
const double HeadingSize = 25.0;

//Colors
// const Appblue = const Color(0xff4e82fc);
const Color Appblue = Color(0xff4d82fc);
const Color Appgrey = Color(0xff7d7d7d);
const Color AppLightGrey = Color(0xffe8e8e8);

//Router related constants
const String SigninScreenRoute = "SigninScreen";
const String SignupScreenRoute = "SignupScreen";
const String ProfileScreenRoute = "ProfileScreen";
const String LandingScreenRoute = "LandingScreen";
const String RegistrationScreen1Route = "RegistrationScreen1";
const String RegistrationScreen2Route = "RegistrationScreen2";
const String RegistrationScreen3Route = "RegistrationScreen3";
const String RegistrationScreen4Route = "RegistrationScreen4";
const String LoginViewRoute = "LoginView";
const String OtpVerificationViewRoute = "OtpVerificationView";
const String Registration1ViewRoute = "Registration1View";
const String Registration2ViewRoute = "Registration2View";
const String Registration3ViewRoute = "Registration3View";
const String Registration4ViewRoute = "Registration4View";
const String LandingViewRoute = "LandingView";

enum ViewState { Idle, Busy }

InputDecoration appInputDecoration(
    {String labelText, IconData icon, bool showIcon}) {
  return InputDecoration(
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide:
            BorderSide(width: 1.5, color: Appgrey, style: BorderStyle.solid)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
            width: 1.5, color: Colors.red, style: BorderStyle.solid)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
            width: 1.5, color: Colors.red, style: BorderStyle.solid)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide:
            BorderSide(width: 1.5, color: Appgrey, style: BorderStyle.solid)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide:
            BorderSide(width: 1.5, color: Appblue, style: BorderStyle.solid)),
    suffixIcon: Container(
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          color: AppLightGrey,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Icon(
        icon,
        color: Appblue,
      ),
    ),
    labelText: labelText,
    labelStyle:
        TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w900),
  );
}
