import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String service;
  final String date;
  final String time;
  final String name;
  final String phone;
  final String details;
  final String id;

  Reservation({
    required this.service,
    required this.date,
    required this.time,
    required this.name,
    required this.phone,
    required this.details,
    required this.id,
  });

  factory Reservation.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Reservation(
      service: data['service'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      details: data['details'] ?? '',
      id: doc.id,
    );
  }
}
