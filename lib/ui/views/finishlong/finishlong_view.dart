import 'package:demando/providers/providers.dart';
import 'package:demando/ui/views/finishlong/finishlong_viewmodel.dart';
import 'package:demando/ui/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        builder: (context, model, child) =>
            Consumer(builder: (context, watch, child) {
              final _products = watch(productsProvider);
              return _products.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, int) {
                        if (data.docs[int].get("category") == "finish long") {
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
        viewModelBuilder: () => FinishLongViewModel());
  }
}
