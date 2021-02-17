import 'package:demando/AppConstants.dart';
import 'package:demando/includes/Heading.dart';
import 'package:demando/models/Profile.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final Profile _profile;
  ProfileView(this._profile);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Appblue,
        title: Text("Profile", style: TextStyle(fontWeight: normalBold)),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Text(
                _profile.name,
                style: TextStyle(
                  color: AppBlack,
                  fontWeight: superBold,
                  fontSize: HeadingSize,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                _profile.email,
                style: TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
              ),
              SizedBox(height: 12),
              Container(
                  child: Text(
                    _profile.status == "verified"
                        ? ("Verified User")
                        : ("Documents under Verification"),
                    style: TextStyle(
                        color: _profile.status == "verified"
                            ? (Colors.blue)
                            : (Colors.deepOrange),
                        fontWeight: normalBold),
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _profile.status == "verified"
                              ? (Colors.blue)
                              : (Colors.deepOrange)),
                      borderRadius: BorderRadius.all(Radius.circular(8))))
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User ID",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  _profile.uid,
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Date of Birth",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  "${getMonth(_profile.dob.month)} ${_profile.dob.day}, ${_profile.dob.year}",
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Member since",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  "${getMonth(_profile.joiningDate.month)} ${_profile.joiningDate.day}, ${_profile.joiningDate.year}",
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(color: AppFontGrey),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Business name",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  _profile.businessName,
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Business address",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  _profile.businessAddress,
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Business type",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  _profile.businessType,
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Documents Submitted on",
                  style:
                      TextStyle(color: AppFontGrey, fontSize: HeadingSize - 8),
                ),
                SizedBox(height: 8),
                Text(
                  "${getMonth(_profile.documentSubmissionDate.month)} ${_profile.documentSubmissionDate.day}, ${_profile.documentSubmissionDate.year}",
                  style: TextStyle(color: AppBlack, fontSize: HeadingSize - 8),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
