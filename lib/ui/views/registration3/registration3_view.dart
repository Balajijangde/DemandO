import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/ui/views/registration3/registration3_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import 'package:demando/ui/widgets/app_button2.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';

class Registration3View extends StatefulWidget {
  const Registration3View({Key key}) : super(key: key);

  @override
  _Registration3ViewState createState() => _Registration3ViewState();
}

class _Registration3ViewState extends State<Registration3View> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _aadharController;
  TextEditingController _gstController;

  @override
  void initState() {
    super.initState();
    _aadharController = TextEditingController();
    _gstController = TextEditingController();
  }

  @override
  void dispose() {
    _aadharController.dispose();
    _gstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Registration3ViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
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
                                    "Submit Documents",
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
                              Stack(children: [
                                TextFormField(
                                  validator: (v) => model.validateAadhar(v),
                                  enabled: model.viewState == ViewState.Idle
                                      ? (true)
                                      : (false),
                                  controller: _aadharController,
                                  decoration: appInputDecoration(
                                      labelText: "Aadhar card",
                                      icon: Icons.file_upload),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: GestureDetector(
                                    onTap: () => model.selectAadhar(
                                        context, _aadharController)
                                    // {
                                    //   if (model.viewState == ViewState.Idle) {
                                    //     radioListDialog(
                                    //         context,
                                    //         "Business type",
                                    //         _businessTypeList, (v) {
                                    //       model.setBusinessType(
                                    //           v.toString(), _controller);
                                    //     });
                                    //   }
                                    // }
                                    ,
                                    child: Container(
                                      height: 10.0,
                                      width: 10.0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(children: [
                                TextFormField(
                                  validator: (v) => model.validateGst(v),
                                  enabled: model.viewState == ViewState.Idle
                                      ? (true)
                                      : (false),
                                  controller: _gstController,
                                  decoration: appInputDecoration(
                                      labelText: "GST Certificate",
                                      icon: Icons.file_upload),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: GestureDetector(
                                    onTap: () => model.selectGst(
                                        context, _gstController),
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
                    Text(
                      "Only .jpg, .png and .pdf formats are accepted",
                      style: TextStyle(color: Appgrey),
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
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              AppButton(
                                onPressed: () => model.completeRegistration3(
                                    _formkey,
                                    _aadharController,
                                    _gstController,
                                    context),
                                title: "Upload & Next",
                              ),
                              Expanded(child: Container())
                            ],
                          )),
                    SizedBox(height: 50.0)
                  ],
                ),
              ),
            )),
        viewModelBuilder: () => Registration3ViewModel());
  }
}
