import 'package:demando/AppConstants.dart';
import 'package:demando/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _model = watch(profileViewModel);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Appblue,
        title: Text("Profile",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25)),
      ),
    );
  }
}
