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
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
                body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                    child: TextField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: appInputDecoration(
                            labelText: "Your Phone Number", icon: Icons.phone)),
                  ),
                  model.viewState == ViewState.Busy
                      ? (CircularProgressIndicator())
                      : (AppButton(
                          onPressed: () => model.testFunction(),
                          title: "Get OTP",
                        ))
                ],
              ),
            )),
        viewModelBuilder: () => LoginViewModel());
  }
}
