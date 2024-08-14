import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? role;
  String? uid;
  bool? isCurrentUser;
  String? pwd;
  UserModel({this.email, this.role, this.uid,this.isCurrentUser = false,this.pwd});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    role = json['role'];
    uid = json['uid'];
    pwd = json['pwd'];
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      email: doc['email'],
      role: doc['role'],
      pwd: doc['pwd'],
    );
  }
}
