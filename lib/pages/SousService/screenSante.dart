import 'package:flutter/material.dart';
import 'package:reservation_service/model/santemodel.dart';
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
        itemCount: healthSubServices.length, // Nombre de services
        itemBuilder: (context, index) {
          final service = healthSubServices[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Coins arrondis
            ),
            margin: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 12), // Réduit les marges
            elevation: 5, // Ombre de la carte
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16), // Paddings pour ajuster la taille
              leading: service.name == "Urgences"
                  ? Icon(Icons.local_hospital,
                      size: 50, color: Colors.red) // Icône pour Urgences
                  : Image.asset(
                      service.imagePath,
                      width: 50, // Ajuster la taille de l'image
                      height: 50,
                      fit: BoxFit.cover,
                    ),
              title: Text(
                service.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight
                        .bold), // Taille de la police pour uniformiser
              ),
              subtitle: Text(
                service.description,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12), // Amélioration du style de la description
              ),
              onTap: () {
                if (service.name == "Urgences") {
                  // Animation de transition vers la page des urgences
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const EmergencyPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                            position: offsetAnimation, child: child);
                      },
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
