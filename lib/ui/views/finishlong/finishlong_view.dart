import 'package:demando/ui/views/finishlong/finishlong_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FinishLongView extends StatefulWidget {
  FinishLongView({Key key}) : super(key: key);

  @override
  _FinishLongViewState createState() => _FinishLongViewState();
}

class _FinishLongViewState extends State<FinishLongView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinishLongViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(child: Text("Finish long view")),
            ),
        viewModelBuilder: () => FinishLongViewModel());
  }
}
