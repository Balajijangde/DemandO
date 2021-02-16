import 'package:demando/providers/providers.dart';
import 'package:demando/ui/views/finishflat/finishflat_viewmodel.dart';
import 'package:demando/ui/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        builder: (context, model, child) =>
            Consumer(builder: (context, watch, child) {
              final _products = watch(productsProvider);
              return _products.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, int) {
                        if (data.docs[int].get("category") == "finish flat") {
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
        viewModelBuilder: () => FinishFlatViewModel());
  }
}
