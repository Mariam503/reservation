import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String serviceName;
  final String address;
  final String phoneNumber;
  final String date;
  final String time;
  final String cleaningType;
  final String areaSize;
  final String additionalInfo;
  final String paymentMethod;
  final double price;
  final Timestamp createdAt;

  Reservation({
    required this.serviceName,
    required this.address,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.cleaningType,
    required this.areaSize,
    required this.additionalInfo,
    required this.paymentMethod,
    required this.price,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,
      'address': address,
      'phoneNumber': phoneNumber,
      'date': date,
      'time': time,
      'cleaningType': cleaningType,
      'areaSize': areaSize,
      'additionalInfo': additionalInfo,
      'paymentMethod': paymentMethod,
      'price': price,
      'createdAt': createdAt,
    };
  }
}
