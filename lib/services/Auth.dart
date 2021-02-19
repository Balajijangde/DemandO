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

  Future getOtp(String phonenumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phonenumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // below code is commented because we dont want automatic verification
          //  await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // print("error from verificationFailed method");
          // print(e);
        },
        codeSent: (String verificationID, int resendToken) {
          // print("code sent successfully");
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          // print("code auto retrieval timeout triggered");
        });
  }
}
