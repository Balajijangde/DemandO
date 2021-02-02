import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:demando/providers/providers.dart";

class FinishedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final connectivityValue = watch(connectivityProvider);
    final products = watch(productsProvider);
    return products.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, int) {
                if (data.docs[int].get("category") == "finished") {
                  return ListTile(
                    title: Text(data.docs[int].get("name")),
                  );
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
