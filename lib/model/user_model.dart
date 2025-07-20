import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final String phoneNo;
  final String password;
  final Timestamp createdAt;
  int? totalOrder;
  double? totalSpend;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNo,
    required this.createdAt,
    required this.password,
    this.totalOrder,
    this.totalSpend,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc , int? totalOrders , double? totalSpending) {
    return UserModel(
      id: doc.id,
      username: doc['username'],
      email: doc['email'],
      phoneNo: doc['phoneNo'],
      createdAt: doc['createdAt'],
      password: doc['password'],
      totalOrder: totalOrders,
      totalSpend: totalSpending
    );
  }
}
