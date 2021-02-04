import 'package:demando/screens/registration/RegistrationScreen1.dart';
import 'package:demando/screens/registration/RegistrationScreen2.dart';
import 'package:demando/screens/registration/RegistrationScreen3.dart';
import 'package:demando/screens/registration/RegistrationScreen4.dart';
import 'package:demando/ui/views/login/login_view.dart';
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
    case RegistrationScreen1Route:
      return PageTransition(
          child: RegistrationScreen1(), type: PageTransitionType.rightToLeft);
    case RegistrationScreen2Route:
      return PageTransition(
          child: RegistrationScreen2(), type: PageTransitionType.rightToLeft);
    case RegistrationScreen3Route:
      return PageTransition(
          child: RegistrationScreen3(), type: PageTransitionType.rightToLeft);
    case RegistrationScreen4Route:
      return PageTransition(
          child: RegistrationScreen4(), type: PageTransitionType.rightToLeft);
    default:
      return MaterialPageRoute(builder: (context) => LoginView());
  }
}
