import 'package:demando/screens/registration/RegistrationScreen1.dart';
import 'package:demando/screens/registration/RegistrationScreen2.dart';
import 'package:demando/screens/registration/RegistrationScreen3.dart';
import 'package:demando/screens/registration/RegistrationScreen4.dart';
import 'package:demando/ui/views/login/login_view.dart';
import 'package:demando/ui/views/otp/otp_verification_view.dart';
import 'package:demando/ui/views/registration1/registration1_view.dart';
import 'package:demando/ui/views/registration2/registration2_view.dart';
import 'package:demando/ui/views/registration3/registration3_view.dart';
import 'package:demando/ui/views/registration4/registration4_view.dart';
import "package:flutter/material.dart";
import "package:demando/AppConstants.dart";
import "package:demando/screens/SigninScreen.dart";
import "package:demando/screens/SignupScreen.dart";
import "package:demando/screens/ProfileScreen.dart";
import "package:demando/screens/LandingScreen.dart";
import "package:page_transition/page_transition.dart";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SigninScreenRoute:
      return MaterialPageRoute(builder: (context) => SigninScreen());
    case SignupScreenRoute:
      //return MaterialPageRoute(builder: (context) => SignupScreen());
      return PageTransition(
          child: SignupScreen(), type: PageTransitionType.rightToLeft);
    case ProfileScreenRoute:
      //return MaterialPageRoute(builder: (context) => ProfileScreen());
      return PageTransition(
          child: ProfileScreen(), type: PageTransitionType.rightToLeft);
    case Registration1ViewRoute:
      return PageTransition(
          child: Registration1View(), type: PageTransitionType.rightToLeft);
    case RegistrationScreen2Route:
      return PageTransition(
          child: RegistrationScreen2(), type: PageTransitionType.rightToLeft);
    case RegistrationScreen3Route:
      return PageTransition(
          child: RegistrationScreen3(), type: PageTransitionType.rightToLeft);
    case RegistrationScreen4Route:
      return PageTransition(
          child: RegistrationScreen4(), type: PageTransitionType.rightToLeft);
    case LandingScreenRoute:
      return PageTransition(
          child: LandingScreen(), type: PageTransitionType.rightToLeft);
    case Registration1ViewRoute:
      return PageTransition(
          child: Registration1View(), type: PageTransitionType.rightToLeft);
    case Registration2ViewRoute:
      return PageTransition(
          child: Registration2View(), type: PageTransitionType.rightToLeft);
    case Registration3ViewRoute:
      return PageTransition(
          child: Registration3View(), type: PageTransitionType.rightToLeft);
    case Registration4ViewRoute:
      return PageTransition(
          child: Registration4View(), type: PageTransitionType.rightToLeft);
    case LoginViewRoute:
      return PageTransition(
          child: LoginView(), type: PageTransitionType.rightToLeft);
    case OtpVerificationViewRoute:
      final Map<String, dynamic> args = settings.arguments;
      return PageTransition(
          child: OtpVerificationView(
              phoneNumber: args["phoneNumber"],
              verificationID: args["verificationID"],
              resendToken: args["resendToken"]),
          type: PageTransitionType.rightToLeft);
    default:
      return MaterialPageRoute(builder: (context) => LandingScreen());
  }
}
