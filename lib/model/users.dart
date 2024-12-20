import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String? profileImageUrl; // Champ facultatif
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    this.profileImageUrl, // Il est maintenant facultatif
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      firstName: data['firstName'],
      profileImageUrl: data['profileImageUrl'], // Peut être nul
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
