import "package:cloud_firestore/cloud_firestore.dart";
import "dart:io";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import "package:commons/commons.dart";

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
      await userscoll.doc(uid).update({
        'passkey': passkey,
        'status': 'verification',
        'registration completed on': Timestamp.now()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> userInitialization(String uid) async {
    CollectionReference userscoll = _database.collection('users');
    var userdoc = await userscoll.doc(uid).get();

    if (userdoc.data() == null) {
      await userscoll
          .doc(uid)
          .set({"joining date": Timestamp.now(), "status": "registration 1"});
      return true;
    }
    return false;
  }

  Future<DocumentReference> placeOrder(
      String uid,
      String productId,
      String productName,
      String passkey,
      double price,
      int quantity,
      double total,
      BuildContext context) async {
    CollectionReference orderscoll = _database.collection('orders');
    DocumentReference userDetail = _database.collection('users').doc(uid);
    try {
      dynamic result = await userDetail.get();
      if (result["status"] != "verified") {
        errorDialog(
            context, "You are currently not eligible for placing orders");
        return null;
      } else if (result["passkey"] != passkey) {
        errorDialog(context, "Wrong passkey provided");
        return null;
      } else {
        DocumentReference result2 = await orderscoll.add({
          "product id": productId,
          "product name": productName,
          "user id": uid,
          "datetime": Timestamp.now(),
          "quantity": quantity,
          "price": price,
          "total": total
        });
        return result2;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<QuerySnapshot> fetchOrders(String uid) async {
    try {
      QuerySnapshot orders = await _database
          .collection('orders')
          .where("user id", isEqualTo: uid)
          .orderBy("datetime", descending: true)
          .get();
      return orders;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
