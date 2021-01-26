import 'package:demando/AppConstants.dart';
import "package:flutter/material.dart";
import 'package:demando/includes/Heading.dart';
import "package:demando/includes/Button.dart";

class ProfileScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> profileformkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PageSidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(width: 2.0, color: Appgrey))),
                child: Text(
                  "Profile",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 20.0),
              Row(children: [
                CircleAvatar(
                    radius: 55.0, child: Image.asset("images/avatar.png")),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "India",
                        style: TextStyle(color: Appgrey),
                      )
                    ],
                  ),
                )
              ]),
              SizedBox(
                height: 30.0,
              ),
              Form(
                  key: profileformkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading3("Business Name"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "creatish.in",
                        ),
                      ),
                      Heading3("Contact Number"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "+91-XXX-XXX-XXXX",
                        ),
                      ),
                      Heading3("E-mail"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "xyz@domain.com",
                        ),
                      ),
                      Heading3("Address"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Street Address",
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Street Address 2",
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "City",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "State/Province",
                              ),
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Postal/Zip code",
                        ),
                      ),
                      Heading3("Type of Business"),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Design & Develop",
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                              Text(
                                "Save Changes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              () {}),
                          BorderedButton("Skip", () {}),
                        ],
                      ),
                      SizedBox(height: 30.0)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
