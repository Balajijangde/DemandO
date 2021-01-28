import "package:cloud_firestore/cloud_firestore.dart";

class Database {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> reg1(String uid, String name, String email, DateTime dob) async {
    CollectionReference userscoll = _database.collection('users');
    try {
      await userscoll.doc(uid).update({
        'name': name,
        'email': email,
        'dob': Timestamp.fromMillisecondsSinceEpoch(dob.millisecondsSinceEpoch),
        'status': 'registration 2'
      });

      print("user added");
    } catch (e) {
      print("some error occured");
      print(e);
    }
  }

  Future<void> reg2(String uid, String businessName, String businessAddress,
      String businessType) async {
    CollectionReference userscoll = _database.collection('users');
    try {
      await userscoll.doc(uid).update({
        'business name': businessName,
        'business address': businessAddress,
        'business type': businessType,
        'status': 'registration 3'
      });

      print("business added");
    } catch (e) {
      print("some error occured");
      print(e);
    }
  }

  Future<void> userInitialization(String uid) async {
    CollectionReference userscoll = _database.collection('users');
    var userdoc = await userscoll.doc(uid).get();
    print(userdoc.data());
    if (userdoc.data() == null) {
      await userscoll
          .doc(uid)
          .set({"joining date": Timestamp.now(), "status": "registration 1"});
    }
  }
}
