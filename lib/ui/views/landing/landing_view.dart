import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:demando/ui/views/finishflat/finishflat_view.dart';
import 'package:demando/ui/views/finishlong/finishlong_view.dart';
import 'package:demando/ui/widgets/custom_appbar.dart';
import 'package:demando/ui/views/semifinished/semifinished_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:demando/providers/providers.dart";
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _snack = locator<SnackbarService>();
  int currentTabIndex = 0;
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        currentTabIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  Future<bool> exitApp() {
    //TODO
    //have to change this function so app will not get rejected in ios platform
    confirmationDialog(context, "Do you want to exit the app",
        positiveText: "Yes", neutralText: "No", positiveAction: () {
      SystemNavigator.pop();
      return true;
    }, confirmationText: "", confirm: false, closeOnBackPress: true);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.exitApp,
      child: Consumer(builder: (context, watch, child) {
        final _authStateProvider = watch(authStateProvider);
        final _model = watch(landingViewModel);
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SafeArea(
                    child: Container(
                  width: double.infinity,
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: _authStateProvider.data == null ||
                                _authStateProvider.data.value == null
                            ? (
                                //show logged out design
                                Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "DemandO",
                                    style: TextStyle(
                                        color: Appblue,
                                        fontWeight: superBold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "www.demando.in",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppBlack,
                                        fontWeight: normalBold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ))
                            : (
                                //show logged in design
                                Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    FirebaseAuth
                                        .instance.currentUser.phoneNumber,
                                    style: TextStyle(
                                        color: AppBlack,
                                        fontWeight: superBold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _model.navigateToProfile(context),
                                    child: Text(
                                      "View profile",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Appblue,
                                          fontWeight: normalBold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Image.asset("images/drawer_logo.png",
                              color: Color.fromRGBO(Appblue.red, Appblue.green,
                                  Appblue.blue, 0.2)))
                    ],
                  ),
                )),
                _authStateProvider.data != null &&
                        _authStateProvider.data.value != null
                    ? (Column(
                        children: [
                          ListTile(
                            onTap: () => _model.navigateToProfile(context),
                            leading: Icon(
                              Icons.account_box_outlined,
                              color: Appblue,
                            ),
                            title: Text(
                              "Profile",
                              style: TextStyle(
                                  fontWeight: normalBold, color: AppBlack),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                color: AppBlack,
                              )),
                          ListTile(
                            leading: Icon(
                              Icons.receipt_long_outlined,
                              color: Appblue,
                            ),
                            title: Text(
                              "My Orders",
                              style: TextStyle(
                                  fontWeight: normalBold, color: AppBlack),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .popAndPushNamed(OrderViewRoute);
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                color: AppBlack,
                              )),
                        ],
                      ))
                    : (Container()),
                ListTile(
                  leading: Icon(Icons.info_outline, color: Appblue),
                  title: Text(
                    "About us",
                    style: TextStyle(fontWeight: normalBold, color: AppBlack),
                  ),
                  onTap: () {},
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      color: AppBlack,
                    )),
                ListTile(
                  leading: Icon(
                    Icons.support_agent,
                    color: Appblue,
                  ),
                  title: Text(
                    "Support",
                    style: TextStyle(fontWeight: normalBold, color: AppBlack),
                  ),
                  onTap: () {},
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      color: AppBlack,
                    )),
                ListTile(
                  leading: Icon(
                    Icons.report_outlined,
                    color: Appblue,
                  ),
                  title: Text(
                    "Terms & Conditions",
                    style: TextStyle(fontWeight: normalBold, color: AppBlack),
                  ),
                  onTap: () {},
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      color: AppBlack,
                    )),
                SizedBox(height: 15),
                _authStateProvider.data == null ||
                        _authStateProvider.data.value == null
                    ? (
                        //show login button
                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(LoginViewRoute);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1.5,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                color: Appblue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Text(
                              "Log in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: normalBold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ))
                    : (
                        //show logout button
                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            _snack.showSnackbar(
                                message: "Successfully logged out");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1.5,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                color: Colors.red[700],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Text(
                              "Log out",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: normalBold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          body: Scaffold(
            body: TabBarView(controller: _controller, children: [
              SemiFinishedView(),
              FinishLongView(),
              FinishFlatView()
            ]),
            appBar: CustomAppBar(
              navigationRow: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.index = 0;
                    },
                    child: Text(
                      "Semi-finished",
                      style: TextStyle(
                        color: currentTabIndex == 0 ? (Appblue) : (Appgrey),
                        fontWeight: superBold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.index = 1;
                    },
                    child: Text(
                      "Finish Long",
                      style: TextStyle(
                        color: currentTabIndex == 1 ? (Appblue) : (Appgrey),
                        fontWeight: superBold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.index = 2;
                    },
                    child: Text(
                      "Finish Flat",
                      style: TextStyle(
                        color: currentTabIndex == 2 ? (Appblue) : (Appgrey),
                        fontWeight: superBold,
                      ),
                    ),
                  )
                ],
              ),
              tabController: _controller,
              actions: _authStateProvider.data == null ||
                      _authStateProvider.data.value == null
                  ? (IconButton(
                      icon: Icon(Icons.login),
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginViewRoute);
                      },
                      color: Colors.white,
                    ))
                  : (IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () {
                        _model.navigateToProfile(context);
                      },
                      color: Colors.white,
                    )),
              leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  }),
            ),
            // AppBar(
            //     leading: IconButton(
            //         icon: Icon(Icons.menu),
            //         onPressed: () {
            //           _scaffoldKey.currentState.openDrawer();
            //         }),
            //     actions: [
            //       _authStateProvider.data == null ||
            //               _authStateProvider.data.value == null
            //           ? (IconButton(
            //               icon: Icon(Icons.login),
            //               onPressed: () {
            //                 Navigator.of(context).pushNamed(LoginViewRoute);
            //               },
            //               color: Colors.white,
            //             ))
            //           : (IconButton(
            //               icon: Icon(Icons.account_circle),
            //               onPressed: () {
            //                 _model.navigateToProfile(context);
            //               },
            //               color: Colors.white,
            //             ))
            //     ],
            //     centerTitle: true,
            //     backgroundColor: Appblue,
            //     title: RichText(
            //       text: TextSpan(
            //           text: "Demand",
            //           style: TextStyle(
            //               fontSize: HeadingSize, fontWeight: normalBold),
            //           children: <TextSpan>[
            //             TextSpan(
            //                 text: "O",
            //                 style: TextStyle(
            //                     fontStyle: FontStyle.italic,
            //                     fontWeight: normalBold,
            //                     fontSize: HeadingSize))
            //           ]),
            //     ),
            //     bottom: TabBar(
            //         indicatorColor: Colors.transparent,
            //         labelStyle: TextStyle(),
            //         unselectedLabelStyle: TextStyle(),
            //         tabs: [
            //           Tab(text: "Semi-Finished"),
            //           Tab(text: "Finish Flat"),
            //           Tab(text: "Finish Long")
            //         ])),
          ),
        );
      }),
    );
  }
}
