import 'package:flutter/material.dart';
import 'package:reservation_service/model/santemodel.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthSubServiceDetailPage extends StatelessWidget {
  final HealthSubService service;

  const HealthSubServiceDetailPage(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              service.imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              service.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text("Appeler"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00796B),
              ),
              onPressed: () => _makePhoneCall(
                  service.contactNumber), // Utilisation de contactNumber
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    // ignore: deprecated_member_use
    if (await canLaunch(launchUri.toString())) {
      // Remplacer 'canLaunchUrl' par 'canLaunch'
      // ignore: deprecated_member_use
      await launch(launchUri.toString()); // Remplacer 'launchUrl' par 'launch'
    } else {
      throw 'Impossible d\'appeler $phoneNumber';
    }
  }
}
