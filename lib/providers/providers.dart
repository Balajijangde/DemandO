import 'package:demando/ui/views/landing/landing_viewmodel.dart';
import 'package:demando/ui/views/order/order_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:connectivity/connectivity.dart";
import "package:cloud_firestore/cloud_firestore.dart";

final authStateProvider =
    StreamProvider<User>((ref) => FirebaseAuth.instance.authStateChanges());

final connectivityProvider = StreamProvider<ConnectivityResult>(
    (ref) => Connectivity().onConnectivityChanged);

final productsProvider = StreamProvider<QuerySnapshot>(
    (ref) => FirebaseFirestore.instance.collection('products').snapshots());

final userInfoProvider = StreamProvider<DocumentSnapshot>((ref) {
  var authState = ref.watch(authStateProvider);
  if (authState.data == null || authState.data.value == null) {
    print("empty auth provider");
    return null;
  } else {
    print("got something");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authState.data.value.uid)
        .snapshots();
  }
});

final landingViewModel =
    ChangeNotifierProvider<LandingViewModel>((ref) => LandingViewModel());

final orderViewModel =
    ChangeNotifierProvider<OrderViewModel>((ref) => OrderViewModel());

// final userDetailsProvider = StreamProvider((ref) {
//   final auth = ref.watch(authStateProvider);
//   if (auth.data != null) {
//     print("successfully fetched user details");
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(auth.data.value.uid)
//         .snapshots();
//   } else {
//     print("got nothing");
//     return null;
//   }
// });

// final userDetailsProvider = StreamProvider((ref) => FirebaseFirestore.instance
//     .collection('users')
//     .doc(FirebaseAuth.instance.currentUser.uid)
//     .snapshots());
