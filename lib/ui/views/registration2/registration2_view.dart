import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/ui/views/registration2/registration2_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import 'package:demando/ui/widgets/app_button2.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';

class Registration2View extends StatefulWidget {
  const Registration2View({Key key}) : super(key: key);

  @override
  _Registration2ViewState createState() => _Registration2ViewState();
}

class _Registration2ViewState extends State<Registration2View> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _controller;
  var _businessTypeList = Set<SimpleItem>()
    ..add(SimpleItem(1, "Retailer"))
    ..add(SimpleItem(2, "Distributor"))
    ..add(SimpleItem(3, "Dealer"));

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  final _businessAddressFocusNode = FocusNode();
  @override
  void dispose() {
    _businessAddressFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Registration2ViewModel>.reactive(
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
                                    "Business details",
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
                                    FocusScope.of(context).requestFocus(
                                        _businessAddressFocusNode);
                                  },
                                  onSaved: (v) => model.setBusinessName(v),
                                  validator: (String value) =>
                                      model.validateBusinessName(value),
                                  decoration: appInputDecoration(
                                      labelText: "Business Name",
                                      icon: Icons.business)),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                enabled: model.viewState == ViewState.Idle
                                    ? (true)
                                    : (false),
                                focusNode: this._businessAddressFocusNode,
                                onSaved: (v) => model.setBusinessAddress(v),
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) =>
                                    model.validateBusinessAddress(value),
                                decoration: appInputDecoration(
                                    labelText: "Business address",
                                    icon: Icons.home),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Stack(children: [
                                TextFormField(
                                  validator: (v) =>
                                      model.validateBusinessType(v),
                                  enabled: model.viewState == ViewState.Idle
                                      ? (true)
                                      : (false),
                                  controller: _controller,
                                  decoration: appInputDecoration(
                                      labelText: "Type of Business",
                                      icon: Icons.category),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (model.viewState == ViewState.Idle) {
                                        radioListDialog(
                                            context,
                                            "Business type",
                                            _businessTypeList, (v) {
                                          model.setBusinessType(
                                              v.toString(), _controller);
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
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              AppButton(
                                onPressed: () => model.completeRegistration2(
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
        viewModelBuilder: () => Registration2ViewModel());
  }
}
