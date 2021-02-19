import "package:demando/ui/widgets/product_tile.dart";
import "package:flutter/material.dart";
import "package:demando/providers/providers.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SemifinishedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userInfo = watch(userInfoProvider);
    final products = watch(productsProvider);
    return products.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, int) {
                if (data.docs[int].get("category") == "semi-finished") {
                  return ProductTile(data.docs[int]);
                }
                return Container();
              });
        },
        loading: () => Center(
              child: CircularProgressIndicator(),
            ),
        error: (e, s) {});
  }
}
