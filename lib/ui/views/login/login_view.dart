import 'package:demando/AppConstants.dart';
import 'package:demando/ui/views/login/login_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
                body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 70.0),
                            child: Image.asset("images/phone.png",
                                fit: BoxFit.contain),
                            // color: Colors.amber,
                            height: 300.0,
                            width: 300.0,
                          ),
                          Text(
                            "Sign In / Sign Up",
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
                                "We will send ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "One Time Password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                          Text("to your contact number.",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Appblue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.elliptical(300.0, 90.0),
                              bottomRight: Radius.elliptical(300.0, 90.0))),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0, top: 30.0),
                      child: Form(
                        key: _loginFormKey,
                        child: TextFormField(
                            enabled: model.handleInputState(),
                            onFieldSubmitted: (String value) {
                              model.getOtp(_loginFormKey);
                            },
                            onSaved: (String value) {
                              model.setPhoneNumber(value);
                            },
                            validator: (String value) =>
                                model.validatePhoneNumber(value),
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: appInputDecoration(
                                labelText: "Your Phone Number",
                                icon: Icons.phone)),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    model.viewState == ViewState.Busy
                        ? (CircularProgressIndicator())
                        : (AppButton(
                            onPressed: () => model.getOtp(_loginFormKey),
                            title: "Get OTP",
                          ))
                  ],
                ),
              ),
            )),
        viewModelBuilder: () => LoginViewModel());
  }
}
