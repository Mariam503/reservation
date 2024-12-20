import 'package:flutter/material.dart';

import 'package:reservation_service/model/santemodel.dart';
import 'package:reservation_service/pages/detailsServices/sousSante/pharmacy/screenPharmacie.dart';
import 'package:reservation_service/pages/detailsServices/sousSante/emergency/emergencyScreen.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Santé"),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: ListView.builder(
        itemCount: healthSubServices.length,
        itemBuilder: (context, index) {
          final service = healthSubServices[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            elevation: 5,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              leading: _getLeadingIcon(service),
              title: Text(
                service.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                service.description,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
              onTap: () => _navigateToServicePage(context, service),
            ),
          );
        },
      ),
    );
  }

  Widget _getLeadingIcon(dynamic service) {
    switch (service.name) {
      case "Urgences":
        return Icon(Icons.local_hospital, size: 50, color: Colors.red);
      case "Pharmacie":
        return Icon(Icons.local_pharmacy, size: 50, color: Colors.green);
      default:
        return Image.asset(service.imagePath,
            width: 50, height: 50, fit: BoxFit.cover);
    }
  }

  void _navigateToServicePage(BuildContext context, dynamic service) {
    Widget? destinationPage;

    switch (service.name) {
      case "Urgences":
        destinationPage = const EmergencyPage();
        break;
      case "Pharmacie":
        destinationPage = PharmacyScreen();
        break;
    }

    if (destinationPage != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              destinationPage!,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    }
  }
}
