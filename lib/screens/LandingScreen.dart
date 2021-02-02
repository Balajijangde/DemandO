// import 'package:firebase_auth/firebase_auth.dart';
// import "package:flutter/material.dart";
// import 'package:demando/AppConstants.dart';

// class LandingScreen extends StatefulWidget {
//   @override
//   _LandingScreenState createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   String user = "none";
//   @override
//   void initState() {
//     super.initState();
//     this.auth.authStateChanges().listen((User user) {
//       if (user != null) {
//         print(user);
//         setState(() {
//           this.user = user.uid;
//         });
//       } else {
//         setState(() {
//           this.user = "none";
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Landing screen"),
//       ),
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               "This is our landing screen",
//               textAlign: TextAlign.center,
//             ),
//             FlatButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, SigninScreenRoute);
//                 },
//                 child: Text("Go to Authenticaton area")),
//             Text(
//               "authentication : $user",
//               textAlign: TextAlign.center,
//             ),
//             FlatButton(
//                 onPressed: () async {
//                   await auth.signOut();
//                 },
//                 child: Text("signout"))
//           ]),
//     );
//   }
// }

import 'package:demando/AppConstants.dart';
import 'package:demando/screens/FinishedScreen.dart';
import 'package:demando/screens/MyOrdersScreen.dart';
import 'package:demando/screens/SemifinishedScreen.dart';
import 'package:demando/screens/WatchlistScreen.dart';
import 'package:demando/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:demando/providers/providers.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Semi-finished",
    "Finished",
    "Watchlist",
    "My Orders"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    actions: [
                      IconButton(
                          icon: Icon(Icons.note),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegistrationScreen1Route);
                          }),
                      IconButton(
                          icon: Icon(Icons.account_circle),
                          onPressed: () {
                            print(_auth.currentUser);
                          }),
                      AuthenticationButton(),
                    ],
                    title: const Text('Demando'),
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      isScrollable: true,
                      // These are the widgets to put in each tab in the tab bar.
                      tabs:
                          _tabs.map((String name) => Tab(text: name)).toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: [
                SemifinishedScreen(),
                FinishedScreen(),
                WatchlistScreen(),
                MyOrdersScreen(),
              ]
              //_tabs.map((String name) {
              //   return SafeArea(
              //     top: false,
              //     bottom: false,
              //     child: Builder(
              //       // This Builder is needed to provide a BuildContext that is "inside"
              //       // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
              //       // find the NestedScrollView.
              //       builder: (BuildContext context) {
              //         return CustomScrollView(
              //           // The "controller" and "primary" members should be left
              //           // unset, so that the NestedScrollView can control this
              //           // inner scroll view.
              //           // If the "controller" property is set, then this scroll
              //           // view will not be associated with the NestedScrollView.
              //           // The PageStorageKey should be unique to this ScrollView;
              //           // it allows the list to remember its scroll position when
              //           // the tab view is not on the screen.
              //           key: PageStorageKey<String>(name),
              //           slivers: <Widget>[
              //             SliverOverlapInjector(
              //               // This is the flip side of the SliverOverlapAbsorber above.
              //               handle:
              //                   NestedScrollView.sliverOverlapAbsorberHandleFor(
              //                       context),
              //             ),
              //             SliverPadding(
              //               padding: const EdgeInsets.all(8.0),
              //               // In this example, the inner scroll view has
              //               // fixed-height list items, hence the use of
              //               // SliverFixedExtentList. However, one could use any
              //               // sliver widget here, e.g. SliverList or SliverGrid.
              //               sliver: SliverFixedExtentList(
              //                 // The items in this example are fixed to 48 pixels
              //                 // high. This matches the Material Design spec for
              //                 // ListTile widgets.
              //                 itemExtent: 0.0,
              //                 delegate: SliverChildBuilderDelegate(
              //                   (BuildContext context, int index) {
              //                     // This builder is called for each child.
              //                     // In this example, we just number each list item.
              //                     return Text("sample view");
              //                     // Container(
              //                     //     color: Color((math.Random().nextDouble() *
              //                     //                     0xFFFFFF)
              //                     //                 .toInt() <<
              //                     //             0)
              //                     //         .withOpacity(1.0));
              //                   },
              //                   // The childCount of the SliverChildBuilderDelegate
              //                   // specifies how many children this inner list
              //                   // has. In this example, each tab has a list of
              //                   // exactly 30 items, but this is arbitrary.
              //                   childCount: 30,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         );
              //       },
              //     ),
              //   );
              // }).toList(),
              ),
        ),
      ),
    );
  }
}

class AuthenticationButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authState = watch(authStateProvider);
    // print(authState);
    if (authState.data.value == null) {
      return IconButton(
          icon: Icon(Icons.login),
          onPressed: () {
            Navigator.pushReplacementNamed(context, SigninScreenRoute);
          });
    } else {
      return IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Auth _auth = Auth();
            _auth.logout();
          });
    }
  }
}
