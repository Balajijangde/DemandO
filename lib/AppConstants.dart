import "package:flutter/material.dart";
import 'package:intl/intl.dart';

//Universal settings
const double PageSidePadding = 30.0;
const double HeadingSize = 25.0;
const double smallHeading = 20.0;
const FontWeight normalBold = FontWeight.w600;
const FontWeight superBold = FontWeight.w700;

//Colors
// const Appblue = const Color(0xff4e82fc);
const Color Appblue = Color(0xff4d82fc);
const Color Appgrey = Color(0xff7d7d7d);
const Color AppLightGrey = Color(0xffe8e8e8);
const Color AppBlack = Color(0xff484848);
const Color AppFontGrey = Color(0xff898989);

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
const String ProfileViewRoute = "ProfileView";
const String OrderViewRoute = "OrderViewRoute";

enum ViewState { Idle, Busy }
enum BottomSheetType { ProductCheckout }

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
    labelStyle: TextStyle(color: Colors.grey.shade600, fontWeight: normalBold),
  );
}

InputDecoration appInputDecorationWithoutIcon({String labelText}) {
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
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.grey.shade600, fontWeight: normalBold),
  );
}

String getMonth(int i) {
  switch (i) {
    case 1:
      return "January";
      break;
    case 2:
      return "February";
      break;
    case 3:
      return "March";
      break;
    case 4:
      return "April";
      break;
    case 5:
      return "May";
      break;
    case 6:
      return "June";
      break;
    case 7:
      return "July";
      break;
    case 8:
      return "August";
      break;
    case 9:
      return "September";
      break;
    case 10:
      return "October";
      break;
    case 11:
      return "November";
      break;
    case 12:
      return "December";
      break;
    default:
      return "none";
  }
}

NumberFormat amountFormatter = NumberFormat('##,##,##,###.##', "en_US");
