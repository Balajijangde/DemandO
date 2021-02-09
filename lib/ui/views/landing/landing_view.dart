import 'package:demando/AppConstants.dart';
import 'package:demando/ui/views/finishlong/finishlong_view.dart';
import 'package:demando/ui/views/landing/landing_viewmodel.dart';
import 'package:demando/ui/views/semifinished/semifinished_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LandingView extends StatefulWidget {
  LandingView({Key key}) : super(key: key);

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              drawer: Drawer(
                // Add a ListView to the drawer. This ensures the user can scroll
                // through the options in the drawer if there isn't enough vertical
                // space to fit everything.
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text('Drawer Header'),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ),
              ),
              body: NestedScrollView(
                  headerSliverBuilder: (context, boxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        floating: true,
                        pinned: true,
                        actions: [
                          IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () {},
                            color: Colors.white,
                          )
                        ],
                        centerTitle: true,
                        backgroundColor: Appblue,
                        title: Text("DemandO",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 25)),
                        forceElevated: boxIsScrolled,
                        bottom: TabBar(
                            controller: _tabController,
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
                            ]),
                      )
                    ];
                  },
                  body: TabBarView(controller: _tabController, children: [
                    SemiFinishedView(),
                    FinishLongView(),
                    FinishLongView()
                  ])),
            ),
        viewModelBuilder: () => LandingViewModel());
  }
}
