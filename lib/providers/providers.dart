import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:connectivity/connectivity.dart";

final authStateProvider =
    StreamProvider<User>((ref) => FirebaseAuth.instance.authStateChanges());

final connectivityProvider = StreamProvider<ConnectivityResult>(
    (ref) => Connectivity().onConnectivityChanged);
