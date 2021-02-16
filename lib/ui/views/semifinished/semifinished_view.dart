import 'package:demando/providers/providers.dart';
import 'package:demando/ui/views/semifinished/semifinished_viewmodel.dart';
import 'package:demando/ui/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
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
        builder: (context, model, child) =>
            Consumer(builder: (context, watch, child) {
              final _products = watch(productsProvider);
              return _products.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, int) {
                        if (data.docs[int].get("category") == "semi-finished") {
                          return ProductTile(data.docs[int]);
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (e, s) {
                    return Center(
                      child: Text("Error occured fetching products"),
                    );
                  });
            }),
        viewModelBuilder: () => SemiFinishedViewModel());
  }
}
