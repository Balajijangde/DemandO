import 'package:demando/ui/views/semifinished/semifinished_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SemiFinishedView extends StatefulWidget {
  SemiFinishedView({Key key}) : super(key: key);

  @override
  _SemiFinishedViewState createState() => _SemiFinishedViewState();
}

class _SemiFinishedViewState extends State<SemiFinishedView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, model, child) => Scaffold(
              body: Center(child: Text("Semi finished view")),
            ),
        viewModelBuilder: () => SemiFinishedViewModel());
  }
}
