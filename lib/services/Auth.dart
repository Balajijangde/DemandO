import "package:firebase_auth/firebase_auth.dart";

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async {
    try {
      String userid = _auth.currentUser.uid;
      return userid;
    } catch (e) {
      print(e);
      return "no user";
    }
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error signing out the user");
    }
  }
}
