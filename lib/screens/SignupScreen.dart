import 'package:demando/AppConstants.dart';
import 'package:demando/includes/Button.dart';
import "package:flutter/material.dart";

class SignupScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> signupformkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PageSidePadding),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              Image.asset("images/logo2.png", width: 100.0),
              SizedBox(height: 30.0),
              Text(
                "Create Your Account",
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 8.0),
              Text(
                "From demand to supply\nwe help you to do it all.",
                style: TextStyle(fontSize: 12.0, color: Appgrey),
              ),
              SizedBox(height: 40.0),
              Form(
                key: signupformkey,
                child: Column(children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: "Phone Number"),
                  ),
                  SizedBox(height: 7.0),
                  Text("You will receive OTP on your number",
                      style: TextStyle(color: Appgrey, fontSize: 12.0)),
                  SizedBox(height: 40.0),
                  FilledButton(
                      Text(
                        "Get OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ), () {
                    Navigator.pushNamed(context, ProfileScreenRoute);
                  })
                ]),
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                      style: TextStyle(color: Appgrey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Login", style: TextStyle(color: Appblue)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
