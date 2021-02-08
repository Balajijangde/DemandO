import "package:cloud_firestore/cloud_firestore.dart";
import "dart:io";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
    } catch (e) {
      print("some error occured");
      print(e);
    }
  }

  Future<void> reg3(String uid, File aadhar, File gst) async {
    try {
      firebase_storage.TaskSnapshot aadharUploadTask = await firebase_storage
          .FirebaseStorage.instance
          .ref('aadhar/$uid/aadhar.${aadhar.path.split('.').last}')
          .putFile(aadhar);
      firebase_storage.TaskSnapshot gstUploadTask = await firebase_storage
          .FirebaseStorage.instance
          .ref('gst/$uid/gst.${gst.path.split('.').last}')
          .putFile(gst);
      CollectionReference userscoll = _database.collection('users');
      await userscoll.doc(uid).update({
        'aadhar': aadharUploadTask.ref.fullPath,
        'gst': gstUploadTask.ref.fullPath,
        'status': 'registration 4'
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> reg4(String uid, String passkey) async {
    CollectionReference userscoll = _database.collection('users');
    try {
      await userscoll
          .doc(uid)
          .update({'passkey': passkey, 'status': 'verification'});
    } catch (e) {
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

  Future<void> placeOrder(String uid, String productId, String passkey,
      int price, int quantity, int total) async {
    CollectionReference orderscoll = _database.collection('orders');
    DocumentReference userDetail = _database.collection('users').doc(uid);
    try {
      dynamic result = await userDetail.get();
      if (result["passkey"] != passkey) {
        print("wrong passkey");
        return;
      } else {
        await orderscoll.add({
          "product id": productId,
          "user id": uid,
          "datetime": Timestamp.now(),
          "quantity": quantity,
          "price": price,
          "total": total
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
