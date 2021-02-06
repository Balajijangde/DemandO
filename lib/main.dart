import 'package:demando/ui/app/locator.dart';
import 'package:demando/widgets/InitializingFirebase.dart';
import 'package:demando/widgets/InitializingFirebaseFailed.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import "package:demando/AppConstants.dart";
import "package:demando/router.dart" as router;
import "package:firebase_core/firebase_core.dart";
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setuplocator();
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return InitializingFirebaseFailed();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return InitializedFirebaseSuccessfuly();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return InitializingFirebase();
      },
    );
  }
}

class InitializedFirebaseSuccessfuly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Appblue);
    return MaterialApp(
      navigatorKey: StackedService.navigatorKey,
      theme: ThemeData(fontFamily: 'Gilroy'),
      title: "DemandO",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
