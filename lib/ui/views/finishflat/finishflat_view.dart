import 'package:demando/ui/views/finishflat/finishflat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FinishFlatView extends StatefulWidget {
  FinishFlatView({Key key}) : super(key: key);

  @override
  _FinishFlatViewState createState() => _FinishFlatViewState();
}

class _FinishFlatViewState extends State<FinishFlatView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinishFlatViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(child: Text("Finish flat view")),
            ),
        viewModelBuilder: () => FinishFlatViewModel());
  }
}
