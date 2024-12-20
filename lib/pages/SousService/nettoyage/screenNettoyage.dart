import 'package:flutter/material.dart';
import 'package:reservation_service/pages/SousService/nettoyage/cleaningServiceDetail.dart';

class CleaningPage extends StatelessWidget {
  final List<Map<String, String>> cleaningServices = [
    {
      'title': 'Nettoyage à domicile',
      'description': 'Un service de nettoyage complet à domicile.',
    },
    {
      'title': 'Nettoyage de bureau',
      'description':
          'Service de nettoyage pour bureaux et espaces professionnels.',
    },
    {
      'title': 'Nettoyage après rénovation',
      'description': 'Nettoyage spécialisé après des travaux de rénovation.',
    },
    // Ajoutez d'autres services de nettoyage ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services de nettoyage"),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: ListView.builder(
        itemCount: cleaningServices.length,
        itemBuilder: (context, index) {
          final service = cleaningServices[index];
          return _buildServiceCard(
              context, service['title']!, service['description']!);
        },
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, String description) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.cleaning_services,
            color: Colors.teal), // Ajout d'une icône de nettoyage
        title: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Naviguer vers la page de détails du service de nettoyage
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CleaningServiceDetailsPage(serviceName: title)),
          );
        },
      ),
    );
  }
}
