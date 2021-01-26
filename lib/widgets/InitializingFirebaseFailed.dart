import "package:flutter/material.dart";

class InitializingFirebaseFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DemandO",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text("Initializing firebase failed")),
      ),
    );
  }
}
