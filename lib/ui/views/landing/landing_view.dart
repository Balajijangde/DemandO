import 'package:commons/commons.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/ui/app/locator.dart';
import 'package:demando/ui/views/finishflat/finishflat_view.dart';
import 'package:demando/ui/views/finishlong/finishlong_view.dart';
import 'package:demando/ui/views/semifinished/semifinished_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:demando/providers/providers.dart";
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingView extends ConsumerWidget {
  Widget retrieveUsername(var authStateProvider) {
    if (authStateProvider.data != null) {
      if (authStateProvider.data.value != null) {
        if (authStateProvider.data.value.displayName != null) {
          return Text(authStateProvider.data.value.displayName);
        } else {
          return Text(authStateProvider.data.value.uid);
        }
      } else {
        return Text("Not Logged in");
      }
    } else {
      return Container();
    }
  }

  Widget retriveUserPhone(var authStateProvider) {
    if (authStateProvider.data != null) {
      if (authStateProvider.data.value != null) {
        return Text(authStateProvider.data.value.phoneNumber);
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _snack = locator<SnackbarService>();
    final _authStateProvider = watch(authStateProvider);
    final _model = watch(landingViewModel);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Appblue),
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Appblue),
                // accountName: retrieveUsername(_authStateProvider),
                accountName: Container(),
                accountEmail: retriveUserPhone(_authStateProvider),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset("images/avatar.png"),
                ),
              ),
            ),
            ListTile(
              title: Text('Check Auth States'),
              onTap: () {
                if (_authStateProvider.data.value == null) {
                  _snack.showSnackbar(message: "No one logged in");
                } else {
                  _snack.showSnackbar(message: "Someone is logged in");
                  print(_authStateProvider.data.value);
                }
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.of(context).popAndPushNamed(LoginViewRoute);
              },
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () => _model.navigateToProfile(context),
            ),
            ListTile(
              title: Text("My Orders"),
              onTap: () {
                Navigator.of(context).popAndPushNamed(OrderViewRoute);
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                _snack.showSnackbar(message: "Successfully logged out");
              },
            )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(children: [
            SemiFinishedView(),
            FinishFlatView(),
            FinishLongView()
          ]),
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  }),
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                  color: Colors.white,
                )
              ],
              centerTitle: true,
              backgroundColor: Appblue,
              title: RichText(
                text: TextSpan(
                    text: "Demand",
                    style: TextStyle(
                        fontSize: HeadingSize, fontWeight: normalBold),
                    children: <TextSpan>[
                      TextSpan(
                          text: "O",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: normalBold,
                              fontSize: HeadingSize))
                    ]),
              ),
              bottom: TabBar(
                  labelStyle: TextStyle(),
                  unselectedLabelStyle: TextStyle(),
                  tabs: [
                    Tab(
                      text: "Semi-Finished",
                    ),
                    Tab(
                      text: "Finish Flat",
                    ),
                    Tab(
                      text: "Finish Long",
                    )
                  ])),
        ),
      ),
    );
  }
}
