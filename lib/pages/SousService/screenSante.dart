import 'package:flutter/material.dart';
import 'package:reservation_service/model/santemodel.dart';
import 'package:reservation_service/pages/detailsServices/sousSante/healthSousService.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Santé"),
        backgroundColor: Color(0xFF00796B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: healthSubServices.length,
          itemBuilder: (context, index) {
            final service = healthSubServices[index];
            return _buildHealthServiceListItem(context, service);
          },
        ),
      ),
    );
  }

  // Widget pour construire chaque élément de la liste des services de santé
  Widget _buildHealthServiceListItem(
      BuildContext context, HealthSubService service) {
    return InkWell(
      onTap: () {
        // Naviguer vers la page de détails du service de santé
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthSubServiceDetailPage(service),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image à gauche
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  service.imagePath, // Utilisation de service.imagePath
                  height: 100, // Ajuster la hauteur de l'image
                  width: 100, // Ajuster la largeur de l'image
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16), // Espace entre l'image et les détails
              // Détails du service de santé à droite
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name, // Utilisation de service.name
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.description, // Utilisation de service.description
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
