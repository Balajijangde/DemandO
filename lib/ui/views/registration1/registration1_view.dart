import 'package:demando/AppConstants.dart';
import 'package:demando/ui/views/registration1/registration1_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import 'package:demando/ui/widgets/app_button2.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';

class Registration1View extends StatefulWidget {
  const Registration1View({Key key}) : super(key: key);

  @override
  _Registration1ViewState createState() => _Registration1ViewState();
}

class _Registration1ViewState extends State<Registration1View> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _controller;

  final emailFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Registration1ViewModel>.reactive(
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
                                      "Personal detail",
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
                                SizedBox(height: 30.0),
                                TextFormField(
                                    enabled: model.viewState == ViewState.Idle
                                        ? (true)
                                        : (false),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(emailFocusNode);
                                    },
                                    onSaved: (v) => model.setName(v),
                                    validator: (String value) =>
                                        model.validateName(value),
                                    decoration: appInputDecoration(
                                        labelText: "Your Name",
                                        icon: Icons.person)),
                                SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  enabled: model.viewState == ViewState.Idle
                                      ? (true)
                                      : (false),
                                  focusNode: this.emailFocusNode,
                                  onSaved: (v) => model.setEmail(v),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (String value) =>
                                      model.validateEmail(value),
                                  decoration: appInputDecoration(
                                      labelText: "Email", icon: Icons.email),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Stack(children: [
                                  TextFormField(
                                    validator: (v) => model.validateDob(v),
                                    enabled: model.viewState == ViewState.Idle
                                        ? (true)
                                        : (false),
                                    controller: _controller,
                                    decoration: appInputDecoration(
                                        labelText: "Date of Birth",
                                        icon: Icons.calendar_today),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (model.viewState == ViewState.Idle) {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1991),
                                                  lastDate: DateTime.now())
                                              .then((value) {
                                            if (value != null) {
                                              model.setDob(value);
                                              _controller.text =
                                                  "${value.day}/${value.month}/${value.year}";
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 10.0,
                                        width: 10.0,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ])
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
                                  onPressed: () => model.completeRegistration1(
                                      _formkey, _controller, context),
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
        viewModelBuilder: () => Registration1ViewModel());
  }
}
