import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demando/models/Profile.dart';
import 'package:demando/ui/views/landing/landing_view.dart';
import 'package:demando/ui/views/login/login_view.dart';
import 'package:demando/ui/views/order/order_view.dart';
import 'package:demando/ui/views/otp/otp_verification_view.dart';
import 'package:demando/ui/views/profile/profile_view.dart';
import 'package:demando/ui/views/registration1/registration1_view.dart';
import 'package:demando/ui/views/registration2/registration2_view.dart';
import 'package:demando/ui/views/registration3/registration3_view.dart';
import 'package:demando/ui/views/registration4/registration4_view.dart';
import "package:flutter/material.dart";
import "package:demando/AppConstants.dart";
import "package:page_transition/page_transition.dart";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingViewRoute:
      return PageTransition(
          child: LandingView(), type: PageTransitionType.rightToLeft);
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
    case ProfileViewRoute:
      final DocumentSnapshot profile = settings.arguments;
      return PageTransition(
          child: ProfileView(Profile(profile)),
          type: PageTransitionType.rightToLeft);
    case OrderViewRoute:
      return PageTransition(
          child: OrderView(), type: PageTransitionType.rightToLeft);
    case OtpVerificationViewRoute:
      final Map<String, dynamic> args = settings.arguments;
      return PageTransition(
          child: OtpVerificationView(
              phoneNumber: args["phoneNumber"],
              verificationID: args["verificationID"],
              resendToken: args["resendToken"]),
          type: PageTransitionType.rightToLeft);
    default:
      return MaterialPageRoute(builder: (context) => LandingView());
  }
}
