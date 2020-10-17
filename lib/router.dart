import "package:flutter/material.dart";
import "package:demando/AppConstants.dart";
import "package:demando/screens/SigninScreen.dart";
import "package:demando/screens/SignupScreen.dart";
import "package:demando/screens/ProfileScreen.dart";
import "package:page_transition/page_transition.dart";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SiginScreenRoute:
      return MaterialPageRoute(builder: (context) => SigninScreen());
    case SignupScreenRoute:
      //return MaterialPageRoute(builder: (context) => SignupScreen());
      return PageTransition(
          child: SignupScreen(), type: PageTransitionType.rightToLeft);
    case ProfileScreenRoute:
      //return MaterialPageRoute(builder: (context) => ProfileScreen());
      return PageTransition(
          child: ProfileScreen(), type: PageTransitionType.rightToLeft);
    default:
      return MaterialPageRoute(builder: (context) => SigninScreen());
  }
}
