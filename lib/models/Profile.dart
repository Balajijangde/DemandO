import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String uid;
  String name;
  String email;
  DateTime dob;
  String status;

  String businessName;
  String businessAddress;
  String businessType;

  DateTime joiningDate;
  DateTime documentSubmissionDate;

  Profile(DocumentSnapshot ref) {
    this.uid = ref.id;
    this.name = ref.get("name");
    this.email = ref.get("email");

    this.businessName = ref.get("business name");
    this.businessAddress = ref.get("business address");
    this.businessType = ref.get("business type");
    this.dob = DateTime.fromMicrosecondsSinceEpoch(
        ref.get("dob").microsecondsSinceEpoch);
    this.joiningDate = DateTime.fromMicrosecondsSinceEpoch(
        ref.get("joining date").microsecondsSinceEpoch);
    this.documentSubmissionDate = DateTime.fromMicrosecondsSinceEpoch(
        ref.get("registration completed on").microsecondsSinceEpoch);
    this.status = ref.get("status");
  }
}
