import 'package:flutter/material.dart';
import 'package:reservation_service/pages/SousService/salonCoiffures/salonRservation.dart';

class SalonDetailsPage extends StatelessWidget {
  final String salonName;
  final String salonDescription;
  final String salonImage;

  const SalonDetailsPage({
    Key? key,
    required this.salonName,
    required this.salonDescription,
    required this.salonImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(salonName),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image principale avec Hero pour une transition fluide
            Hero(
              tag: salonName,
              child: Image.asset(
                salonImage,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            // Informations principales du salon
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom du salon
                  Text(
                    salonName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description du salon
                  Text(
                    salonDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Section des services proposés
                  const Text(
                    'Services proposés',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      _buildServiceItem(
                        icon: Icons.cut,
                        title: 'Coupe de cheveux',
                        description:
                            'Coupe professionnelle adaptée à votre style.',
                      ),
                      _buildServiceItem(
                        icon: Icons.color_lens,
                        title: 'Coloration',
                        description: 'Couleurs vibrantes et soins capillaires.',
                      ),
                      _buildServiceItem(
                        icon: Icons.spa,
                        title: 'Soins capillaires',
                        description: 'Traitements pour cheveux abîmés.',
                      ),
                      _buildServiceItem(
                        icon: Icons.brush,
                        title: 'Coiffure événementielle',
                        description:
                            'Styles élégants pour toutes vos occasions.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Bouton de réservation
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Naviguer vers la page de réservation
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationPage(
                                salonName:
                                    "Salon de beauté", // Remplacez par la valeur appropriée
                                salonDescription:
                                    "Description du salon", // Remplacez par la valeur appropriée),
                              ),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00796B),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Réserver un service',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour un élément de service
  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00796B), size: 36),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
