import 'package:demando/AppConstants.dart';
import 'package:demando/ui/widgets/app_button.dart';
import "package:flutter/material.dart";
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import 'otp_verification_viewmodel.dart';

class OtpVerificationView extends StatefulWidget {
  final String verificationID;
  final int resendToken;
  final String phoneNumber;
  const OtpVerificationView(
      {Key key, this.verificationID, this.phoneNumber, this.resendToken})
      : super(key: key);

  @override
  _OtpVerificationViewState createState() => _OtpVerificationViewState(
      phoneNumber: this.phoneNumber,
      verificationID: this.verificationID,
      resendToken: this.resendToken);
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  _OtpVerificationViewState(
      {this.phoneNumber, this.resendToken, this.verificationID});
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final String phoneNumber;
  final String verificationID;
  final int resendToken;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
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
                            "Verification Code",
                            style: TextStyle(
                                fontSize: HeadingSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Please enter verification code",
                              style: TextStyle(color: Colors.white)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "sent to",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "+91 $phoneNumber",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
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
                        child: PinCodeTextField(
                          onCompleted: (String value) => model.verifyOtp(
                              _formkey,
                              this.phoneNumber,
                              this.verificationID,
                              this.resendToken,
                              context),
                          onSubmitted: (String value) => model.verifyOtp(
                              _formkey,
                              this.phoneNumber,
                              this.verificationID,
                              this.resendToken,
                              context),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) => model.validateOtp(value),
                          enabled: model.handleInputState(),
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 6,
                          showCursor: false,
                          onSaved: (String value) => model.setOtp(value),
                          pinTheme: PinTheme(
                            activeColor: Appblue,
                            inactiveColor: Appgrey,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                          ),
                          onChanged: (value) {},
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                    model.viewState == ViewState.Busy
                        ? (CircularProgressIndicator())
                        : (AppButton(
                            onPressed: () => model.verifyOtp(
                                _formkey,
                                this.phoneNumber,
                                this.verificationID,
                                this.resendToken,
                                context),
                            title: "Verify",
                          ))
                  ],
                ),
              ),
            )),
        viewModelBuilder: () => OtpVerificationViewModel());
  }
}
