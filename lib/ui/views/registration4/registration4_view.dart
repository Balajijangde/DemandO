import 'package:demando/AppConstants.dart';
import 'package:demando/ui/views/registration4/registration4_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import 'package:demando/ui/widgets/app_button2.dart';
import "package:flutter/material.dart";
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class Registration4View extends StatefulWidget {
  const Registration4View({Key key}) : super(key: key);

  @override
  _Registration4ViewState createState() => _Registration4ViewState();
}

class _Registration4ViewState extends State<Registration4View> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Registration4ViewModel>.reactive(
        builder: (context, model, child) => WillPopScope(
              onWillPop: () => model.cancelRegistration(context),
              child: Scaffold(
                  body: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.0,
                            ),
                            Text(
                              "Registration",
                              style: TextStyle(
                                  fontSize: HeadingSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "We will ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "Not share ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  "your",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Text("any information with anyone",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Appblue,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.elliptical(300.0, 90.0),
                                bottomRight: Radius.elliptical(300.0, 90.0))),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.35,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 50.0, left: 50.0, top: 30.0, bottom: 20.0),
                        child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Row(children: [
                                  Column(children: [
                                    Text(
                                      "Create Passkey",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Appgrey,
                                        fontSize: HeadingSize,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      height: 2,
                                      color: Appgrey,
                                    )
                                  ]),
                                ]),
                                SizedBox(
                                  height: 30.0,
                                ),
                                PinCodeTextField(
                                    onSaved: (v) => model.setPasskey(v),
                                    onCompleted: (v) =>
                                        model.completeRegistration4(
                                            _formkey, context),
                                    onSubmitted: (v) =>
                                        model.completeRegistration4(
                                            _formkey, context),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (v) => model.validatePasskey(v),
                                    showCursor: false,
                                    pinTheme: PinTheme(
                                      activeColor: Appblue,
                                      inactiveColor: Appgrey,
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      // activeFillColor: Colors.transparent,
                                    ),
                                    keyboardType: TextInputType.number,
                                    appContext: context,
                                    length: 4,
                                    onChanged: (String v) {}),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "This passkey is important to place orders",
                                  style: TextStyle(color: Appgrey),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      model.viewState == ViewState.Busy
                          ? (CircularProgressIndicator())
                          : (Row(
                              children: [
                                Expanded(child: Container()),
                                AppButton2(
                                  title: "Cancel",
                                  onPressed: () =>
                                      model.cancelRegistration(context),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                AppButton(
                                  onPressed: () => model.completeRegistration4(
                                      _formkey, context),
                                  title: "Save & Next",
                                ),
                                Expanded(child: Container())
                              ],
                            )),
                      SizedBox(height: 50.0)
                    ],
                  ),
                ),
              )),
            ),
        viewModelBuilder: () => Registration4ViewModel());
  }
}
