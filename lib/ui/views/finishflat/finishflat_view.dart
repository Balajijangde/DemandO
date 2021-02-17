import 'package:demando/providers/providers.dart';
import 'package:demando/ui/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishFlatView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final products = watch(productsProvider);
    return products.when(
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
  }
}
