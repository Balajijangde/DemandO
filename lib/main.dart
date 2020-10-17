import "package:flutter/material.dart";
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import "package:demando/AppConstants.dart";
import "package:demando/router.dart" as router;
void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Appblue);
    return MaterialApp(
      title: "DemandO",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: SiginScreenRoute,
    );
  }
}
