import "package:flutter/material.dart";
import "package:demando/providers/providers.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SemifinishedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final connectivityValue = watch(connectivityProvider);
    return Center(
      child: Text(connectivityValue.data.value.toString()),
    );
  }
}
