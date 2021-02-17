import 'package:demando/AppConstants.dart';
import "package:flutter/material.dart";

class InitializingFirebase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DemandO",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Appblue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(),
            Text("Loading...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: normalBold,
                  fontSize: HeadingSize,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
